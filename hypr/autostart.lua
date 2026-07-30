-- Extra autostart processes.
-- NOTE: workspaces 2 & 4 used to live on the second monitor (HDMI-A-2). With
-- only HDMI-A-1 connected, everything opens on the single display's workspaces.

-- Workspace 1: terminal + browser
o.exec_on_start("[workspace 1 silent] " .. o.launch("xdg-terminal-exec"))
o.exec_on_start("[workspace 1 silent] omarchy-launch-browser")

-- Workspace 2: system monitor + music
o.exec_on_start("[workspace 2 silent] omarchy-launch-tui btop")
o.exec_on_start("[workspace 2 silent] " .. o.launch("spotify"))

-- Workspace 3: editor (Cursor)
o.exec_on_start("[workspace 3 silent] " .. o.launch("cursor"))

-- Workspace 4: Discord
o.exec_on_start("[workspace 4 silent] " .. o.launch("discord"))

-- Workspace 5: 1Password
o.exec_on_start("[workspace 5 silent] " .. o.launch("1password"))
