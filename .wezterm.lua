local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local gitbash = {"C:\\Program Files\\Git\\bin\\bash.exe", "-i", "-l"}

local function create_action(layout_setup_function)
    return wezterm.action_callback(function(window, pane)
        local tab, pane, window = window:mux_window():spawn_tab{}
        layout_setup_function(tab, pane, window)
    end)
end

local function setup_debian_layout(tab, pane, window)
    pane:send_text("ssh -q root@proxmox\n")
    tab:set_title("Proxmox - Debian")
end

local function setup_proxmox_layout(tab, pane, window)
    local top_pane = pane:split{
        size = 0.5,
        direction = 'Top'
    }
    local bottom_pane = pane

    local bottom_right_pane = bottom_pane:split{
        size = 0.5
    }
    local bottom_left_pane = bottom_pane

    top_pane:send_text("ssh -q root@proxmox\n")
    bottom_left_pane:send_text("ssh -q root@proxmox\n")
    bottom_right_pane:send_text("ssh -q root@proxmox\n")

    tab:set_title("Proxmox")
end

local function setup_wsl_layout(tab, pane, window)
    local top_pane = pane:split{
        size = 0.5,
        direction = 'Top'
    }
    local bottom_pane = pane

    top_pane:send_text("wsl\n")
    bottom_pane:send_text("wsl\n")

    tab:set_title("WSL - K8S/Ubuntu")
end

local function setup_z8_layout(tab, pane, window)
    local top_pane = pane:split{
        size = 0.5,
        direction = 'Top'
    }
    local bottom_pane = pane

    top_pane:send_text("ssh z8\n")
    bottom_pane:send_text("ssh z8\n")

    tab:set_title("Data&AI Z8")
end

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

wezterm.on('new-tab-button-click', function(window, pane, button, default_action)
    wezterm.log_info('new-tab', window, pane, button, default_action)
    -- We're explicitly going to perform the default action
    if default_action then
        window:perform_action(default_action, pane)
    end
    -- and tell wezterm that we handled the event so that it doesn't
    -- perform it a second time.
    return false
end)

return {
    color_scheme = "Dracula",
    -- color_scheme = 'Hardcore',

    font = wezterm.font('JetBrains Mono', {
        -- weight = 'Bold',
        -- italic = true
    }),

    line_height = 1.2,

    default_prog = gitbash,

    window_background_opacity = 1,

    font_size = 10.0,

    enable_scroll_bar = true,

    window_close_confirmation = "NeverPrompt",

    skip_close_confirmation_for_processes_named = {'bash.exe', 'cmd.exe', 'pwsh.exe', 'powershell.exe'},

    inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.7
    },

    keys = {{
        key = 'K',
        mods = 'CTRL|SHIFT',
        action = act.ClearScrollback 'ScrollbackOnly'
    }, {
        key = 'K',
        mods = 'CTRL|SHIFT',
        action = act.ClearScrollback 'ScrollbackAndViewport'
    }, {
        key = 'K',
        mods = 'CTRL|SHIFT',
        action = act.Multiple {act.ClearScrollback 'ScrollbackAndViewport', act.SendKey {
            key = 'L',
            mods = 'CTRL'
        }}
    }, {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.ShowLauncher
    }, {
        key = "d",
        mods = "ALT",
        action = create_action(setup_debian_layout)
    }, {
        key = "w",
        mods = "ALT",
        action = create_action(setup_wsl_layout)
    }, {
        key = "p",
        mods = "ALT",
        action = create_action(setup_proxmox_layout)
    }, {
        key = "z",
        mods = "ALT",
        action = create_action(setup_z8_layout)
    }, {
        key = 'v',
        mods = 'CTRL',
        action = act.SplitVertical {
            domain = 'CurrentPaneDomain'
        }
    }, {
        key = 'h',
        mods = 'CTRL',
        action = act.SplitHorizontal {
            domain = 'CurrentPaneDomain'
        }
    }}

}
