-- Personal window rules (migrated from windows.conf).
-- Your other two rules (suppress_event maximize + the XWayland no_focus fix)
-- are now provided by Omarchy defaults, so only the Cursor rule remains here.

-- Ensure Cursor gets rounded corners even if it ignores the global rounding.
o.window("^(cursor|Cursor)$", { rounding = 8 })
