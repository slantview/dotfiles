-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and resolutions possible: hyprctl monitors all

-- Shared fallback: extend unknown/external displays at their preferred mode
-- and automatic scale. Host profiles can add a specific connector override.
hl.env("GDK_SCALE", "1")
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
