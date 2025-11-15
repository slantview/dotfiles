#!/bin/bash
# Fix Linux NVIDIA driver for multi-GPU (RTX 3060 Ti + GTX 1070)
# Run with: sudo ./fix-linux-gpu-driver.sh

if [ "$EUID" -ne 0 ]; then 
    echo "This script must be run with sudo"
    exit 1
fi

echo "=== Configuring Linux NVIDIA Driver for Multi-GPU ==="
echo ""

# 1. Ensure nouveau is blacklisted
echo "1. Blacklisting nouveau..."
BLACKLIST="/etc/modprobe.d/blacklist-nvidia-nouveau.conf"
if ! grep -q "blacklist nouveau" "$BLACKLIST" 2>/dev/null; then
    echo "blacklist nouveau" >> "$BLACKLIST"
    echo "options nouveau modeset=0" >> "$BLACKLIST"
    echo "✓ Blacklisted nouveau"
else
    echo "✓ nouveau already blacklisted"
fi

# 2. Create udev rule to enable GPU before driver probes
echo ""
echo "2. Creating udev rule to enable GTX 1070 early..."
UDEV_RULE="/etc/udev/rules.d/99-enable-gtx1070.rules"
cat > "$UDEV_RULE" << 'EOF'
# Enable GTX 1070 before NVIDIA driver probes it
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{device}=="0x1b81", ATTR{enable}="1", RUN+="/bin/sh -c 'echo 0000:08:00.0 > /sys/bus/pci/drivers/nvidia/bind 2>/dev/null || true'"
EOF
echo "✓ Created udev rule: $UDEV_RULE"

# 2b. Create systemd service to bind GPU after driver loads
echo ""
echo "2b. Creating systemd service to bind GTX 1070 after driver loads..."
SERVICE_FILE="/etc/systemd/system/bind-gtx1070.service"
cat > "$SERVICE_FILE" << 'EOF'
[Unit]
Description=Bind GTX 1070 to NVIDIA driver
After=systemd-udev-settle.service
Wants=systemd-udev-settle.service

[Service]
Type=oneshot
# Wait for NVIDIA driver to be fully loaded
ExecStartPre=/bin/sh -c 'while ! lsmod | grep -q "^nvidia "; do sleep 0.1; done'
# Register device ID and bind
ExecStart=/bin/sh -c 'echo "10de 1b81" > /sys/bus/pci/drivers/nvidia/new_id 2>/dev/null; sleep 1; echo 0000:08:00.0 > /sys/bus/pci/drivers/nvidia/bind 2>/dev/null || true'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable bind-gtx1070.service
echo "✓ Created and enabled systemd service: $SERVICE_FILE"

# 3. Configure modprobe
echo ""
echo "3. Configuring modprobe..."
MODPROBE_CONF="/etc/modprobe.d/nvidia.conf"
if [ ! -f "$MODPROBE_CONF" ]; then
    touch "$MODPROBE_CONF"
fi

# Add device alias if not present
if ! grep -q "pci:v000010DEd00001B81" "$MODPROBE_CONF"; then
    echo "" >> "$MODPROBE_CONF"
    echo "# Force recognition of GTX 1070" >> "$MODPROBE_CONF"
    echo "alias pci:v000010DEd00001B81sv*sd*bc*sc*i* nvidia" >> "$MODPROBE_CONF"
    echo "✓ Added device alias"
else
    echo "✓ Device alias already present"
fi

# Ensure nvidia-drm modeset is set (fix typo if present)
sed -i 's/options nvidia_drm modeset=1/options nvidia-drm modeset=1/g' "$MODPROBE_CONF" 2>/dev/null || true
if ! grep -q "options nvidia-drm modeset=1" "$MODPROBE_CONF"; then
    echo "options nvidia-drm modeset=1" >> "$MODPROBE_CONF"
    echo "✓ Added nvidia-drm modeset option"
else
    echo "✓ nvidia-drm modeset already configured"
fi

echo ""
echo "=== Summary ==="
echo "✓ nouveau blacklisted"
echo "✓ udev rule created to enable GPU early"
echo "✓ systemd service created to bind GPU after driver loads"
echo "✓ modprobe config updated"
echo ""
echo "=== Next Steps ==="
echo "1. Reboot your system"
echo "2. After reboot, check:"
echo "   nvidia-smi -L  # Should show 2 GPUs"
echo "   hyprctl monitors  # Should show your 4K monitor"
echo "   systemctl status bind-gtx1070.service  # Check service status"
echo ""
echo "If the GPU still doesn't bind, try manually:"
echo "   sudo sh -c 'echo \"10de 1b81\" > /sys/bus/pci/drivers/nvidia/new_id'"
echo "   sudo sh -c 'echo 0000:08:00.0 > /sys/bus/pci/drivers/nvidia/bind'"
echo ""
echo "To run this script:"
echo "   sudo ~/dotfiles/hypr/scripts/fix-linux-gpu-driver.sh"
