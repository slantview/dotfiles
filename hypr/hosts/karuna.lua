-- karuna: LG UltraGear+ reports a stretched 3840x2160 preferred mode;
-- use its native 21:9 mode instead. Other displays use the shared fallback.
hl.monitor({ output = "HDMI-A-1", mode = "3440x1440@240", position = "auto", scale = 1 })

-- Desktop NVIDIA setup (RTX 3060 Ti + GTX 1070).
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GL_GSYNC_ALLOWED", "0")
hl.env("__GL_VRR_ALLOWED", "0")
hl.env("NVD_BACKEND", "direct")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
