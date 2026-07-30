-- Personal environment variables (migrated from envs.conf).
-- Loaded via require("hypr.envs") in hyprland.lua — the new Lua setup no longer
-- sources envs.conf, so these must live here to take effect.

-- Input method (fcitx5). Automatically disabled for sudo password prompts.
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")

-- Multi-GPU NVIDIA (RTX 3060 Ti + GTX 1070).
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GL_GSYNC_ALLOWED", "0")
hl.env("__GL_VRR_ALLOWED", "0")

-- NVIDIA hardware video acceleration (VA-API).
hl.env("NVD_BACKEND", "direct")
hl.env("LIBVA_DRIVER_NAME", "nvidia")

-- Uncomment if cursor issues occur with multi-GPU.
-- hl.env("WLR_NO_HARDWARE_CURSORS", "1")
