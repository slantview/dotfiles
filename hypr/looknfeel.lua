-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    -- Tight gaps.
    gaps_in = 2,
    gaps_out = 2,
    border_size = 3,

    -- Rudō theme — saffron-orange active border. NOTE: this loads after the
    -- current theme, so it overrides the theme's border colors on purpose.
    col = {
      active_border = "rgba(FF8C00aa)",
      inactive_border = "rgba(595959aa)",
    },

    -- Resize windows by dragging borders/gaps.
    resize_on_border = true,
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
  decoration = {
    rounding = 8,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },
})

-- Animations use the Omarchy defaults (they matched your old custom curves).

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })
