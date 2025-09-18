-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

wezterm.on("user-var-changed", function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while number_value > 0 do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

config.initial_rows = 80
config.initial_cols = 120
config.color_scheme = "Catppuccin Latte"
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", {
    weight = "DemiBold",
    stretch = "Normal",
    style = "Normal",
})
config.font_size = 16.0
config.enable_tab_bar = false
config.keys = {
    { key = "'", mods = "CTRL", action = wezterm.action.ClearScrollback("ScrollbackAndViewport") },
    { key = "_", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    -- navigate between panes using ctrl + hjkl like vim
    { key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
}
config.mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

return config
