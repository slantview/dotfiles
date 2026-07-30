-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and resolutions possible: hyprctl monitors all

-- Straight 1x setup: this LG UltraGear+ is a low-DPI (~82 PPI) ultrawide,
-- so both scales stay at 1 (2x would double-size all UI).
local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Fallback default for any unknown/other output.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- LG UltraGear+ (HDMI-A-1) is a 21:9 ultrawide. Its EDID "preferred" mode is a
-- 16:9 3840x2160 that gets stretched into the 21:9 panel, so pin the native mode.
hl.monitor({ output = "HDMI-A-1", mode = "3440x1440@240", position = "auto", scale = omarchy_monitor_scale })

-- Second monitor (ASUS 4K on HDMI-A-2) is not connected right now. Re-add when it returns:
-- hl.monitor({ output = "HDMI-A-2", mode = "2560x1440@59.95", position = "3440x0", scale = 1 })
