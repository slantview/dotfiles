-- Load one tracked per-computer profile after shared Omarchy/user defaults.
-- The kernel hostname is authoritative; inherited HOSTNAME can be stale.
local source = assert(io.open("/proc/sys/kernel/hostname", "r"))
local hostname = source:read("*l")
source:close()

-- Never let an unexpected hostname escape the profiles directory.
if hostname and hostname:match("^[%w%-]+$") then
  local profile = os.getenv("HOME") .. "/.config/hypr/hosts/" .. hostname .. ".lua"
  local file = io.open(profile, "r")
  if file then
    file:close()
    dofile(profile)
  end
end
