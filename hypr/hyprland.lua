-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Use Omarchy's module-path and reload setup (including generated theme state).
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- All Omarchy default setups
require("default.hypr.omarchy")

-- Change your own setup in these files and override defaults.
require("hypr.monitors")
require("hypr.input")
require("hypr.envs")
require("hypr.host")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.windows")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })
