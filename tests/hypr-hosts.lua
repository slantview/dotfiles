-- Run from the repository root with: lua tests/hypr-hosts.lua
local root = assert(os.getenv("DOTFILES_DIR"), "set DOTFILES_DIR to the repository root")
local original_getenv = os.getenv
local original_open = io.open
local calls = {}

local function load(host)
  io.open = function(path, mode)
    if path == "/proc/sys/kernel/hostname" then
      return { read = function() return host end, close = function() end }
    end
    return original_open(path, mode)
  end
  calls = { monitors = {}, configs = {}, envs = {}, windows = {} }
  _G.hl = {
    monitor = function(value) table.insert(calls.monitors, value) end,
    config = function(value) table.insert(calls.configs, value) end,
    env = function(name, value) calls.envs[name] = value end,
  }
  _G.o = { window = function(...) table.insert(calls.windows, { ... }) end }
  os.getenv = function(key)
    if key == "HOSTNAME" then return "misleading-env-name" end
    return original_getenv(key)
  end
  local ok, err = pcall(function()
    -- The real entrypoint loads Omarchy defaults; exercise the host dispatcher here.
    dofile(root .. "/hypr/monitors.lua")
    dofile(root .. "/hypr/input.lua")
    dofile(root .. "/hypr/envs.lua")
    dofile(root .. "/hypr/host.lua")
  end)
  os.getenv = original_getenv
  io.open = original_open
  if not ok then error(err) end
  return calls
end

local function find_monitor(monitors, output)
  for _, monitor in ipairs(monitors) do
    if monitor.output == output then return monitor end
  end
end

-- Use an injected system hostname; inherited HOSTNAME is deliberately misleading.
local laptop = load("satori")
assert(find_monitor(laptop.monitors, "eDP-1").scale == 1)
assert(find_monitor(laptop.monitors, "eDP-1").mode == "1920x1200@60")
assert(find_monitor(laptop.monitors, "").scale == "auto", "unknown external displays must auto-extend")
assert(laptop.envs.GBM_BACKEND == nil, "NVIDIA variables must not reach Intel laptop")
assert(#laptop.configs == 0, "satori should use shared Omarchy input defaults")

local desktop = load("karuna")
assert(find_monitor(desktop.monitors, "HDMI-A-1").mode == "3440x1440@240")
assert(desktop.envs.GBM_BACKEND == "nvidia-drm")
assert(#desktop.configs == 0, "karuna should use shared Omarchy input defaults")

local fallback = load("unknown-host")
assert(find_monitor(fallback.monitors, "").scale == "auto")
assert(#fallback.monitors == 1, "unknown hosts must not inherit specific monitor settings")
assert(#fallback.configs == 0, "unknown hosts must use Omarchy input defaults")
assert(fallback.envs.GBM_BACKEND == nil)
print("Hyprland host profile tests passed")
