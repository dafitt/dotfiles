hl.bind("SUPER + CONTROL + Q", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("SUPER + CONTROL + R", hl.dsp.exec_cmd("hyprctl reload forcerendererreload"))
hl.bind("SUPER + Odiaeresis",
    function()
        hl.timer(function()
            hl.dispatch(hl.dsp.dpms({ action = "disable" }))
        end, { timeout = 500, type = "oneshot" })
    end)

-- Window control
hl.bind("SUPER + Delete", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind("SUPER + X", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + X", hl.dsp.window.kill())
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + R", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + H", hl.dsp.window.swap({ next = true }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ prev = true }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen_state({ internal = 2, client = 0, action = "toggle" }))
hl.bind("SUPER + A", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + Z", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind("SUPER + SHIFT + Z", hl.dsp.window.alter_zorder({ mode = "bottom" }))
hl.bind("SUPER + B", hl.dsp.window.pin())
hl.bind("SUPER + Left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + Right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + Up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + Down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + Tab", hl.dsp.window.cycle_next({ next = true }))
hl.bind("SUPER + SHIFT + Left", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT + Right", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + SHIFT + Up", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + Down", hl.dsp.window.swap({ direction = "d" }))
hl.bind("SUPER + SHIFT + Tab", hl.dsp.window.swap({ next = true }))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())   -- LMB
hl.bind("SUPER + mouse:273", hl.dsp.window.resize()) -- RMB
hl.bind("SUPER + ALT + Plus", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind("SUPER + ALT + Minus", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind("SUPER + ALT + Right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind("SUPER + ALT + Left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind("SUPER + ALT + Down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
hl.bind("SUPER + ALT + Up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))

-- Window groups
hl.bind("SUPER + CONTROL + G", hl.dsp.group.toggle())
hl.bind("SUPER + G", hl.dsp.group.next())
hl.bind("SUPER + SHIFT + G", hl.dsp.group.next())
hl.bind("SUPER + SHIFT + CONTROL + Left", hl.dsp.window.move({ into_or_create_group = "l" }))
hl.bind("SUPER + SHIFT + CONTROL + Right", hl.dsp.window.move({ into_or_create_group = "r" }))
hl.bind("SUPER + SHIFT + CONTROL + Up", hl.dsp.window.move({ into_or_create_group = "u" }))
hl.bind("SUPER + SHIFT + CONTROL + Down", hl.dsp.window.move({ into_or_create_group = "d" }))

-- Workspace control
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10, }))
hl.bind("SUPER + D", hl.dsp.focus({ workspace = "name:D" }),
    { description = "Focus the desktop / hide all windows" })
hl.bind("SUPER + code:87", hl.dsp.focus({ workspace = 1 }))    -- Numpad
hl.bind("SUPER + code:88", hl.dsp.focus({ workspace = 2 }))    -- Numpad
hl.bind("SUPER + code:89", hl.dsp.focus({ workspace = 3 }))    -- Numpad
hl.bind("SUPER + code:83", hl.dsp.focus({ workspace = 4 }))    -- Numpad
hl.bind("SUPER + code:84", hl.dsp.focus({ workspace = 5 }))    -- Numpad
hl.bind("SUPER + code:85", hl.dsp.focus({ workspace = 6 }))    -- Numpad
hl.bind("SUPER + code:79", hl.dsp.focus({ workspace = 7 }))    -- Numpad
hl.bind("SUPER + code:80", hl.dsp.focus({ workspace = 8 }))    -- Numpad
hl.bind("SUPER + code:81", hl.dsp.focus({ workspace = 9 }))    -- Numpad
hl.bind("SUPER + code:91", hl.dsp.focus({ workspace = 10 }))   -- Numpad
hl.bind("SUPER + code:86", hl.dsp.focus({ workspace = "+1" })) -- Numpad +
hl.bind("SUPER + code:82", hl.dsp.focus({ workspace = -1 }))   -- Numpad -
hl.bind("SUPER + backspace", hl.dsp.focus({ workspace = "previous" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = -1 }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "+1" }))
-- Move active window to a workspace
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = false }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = false }))
hl.bind("SUPER + SHIFT + code:87", hl.dsp.window.move({ workspace = 1, follow = false }))    -- Numpad
hl.bind("SUPER + SHIFT + code:88", hl.dsp.window.move({ workspace = 2, follow = false }))    -- Numpad
hl.bind("SUPER + SHIFT + code:89", hl.dsp.window.move({ workspace = 3, follow = false }))    -- Numpad
hl.bind("SUPER + SHIFT + code:83", hl.dsp.window.move({ workspace = 4, follow = false }))    -- Numpad
hl.bind("SUPER + SHIFT + code:84", hl.dsp.window.move({ workspace = 5, follow = false }))    -- Numpad
hl.bind("SUPER + SHIFT + code:85", hl.dsp.window.move({ workspace = 6, follow = false }))    -- Numpad
hl.bind("SUPER + SHIFT + code:79", hl.dsp.window.move({ workspace = 7, follow = false }))    -- Numpad
hl.bind("SUPER + SHIFT + code:80", hl.dsp.window.move({ workspace = 8, follow = false }))    -- Numpad
hl.bind("SUPER + SHIFT + code:81", hl.dsp.window.move({ workspace = 9, follow = false }))    -- Numpad
hl.bind("SUPER + SHIFT + code:91", hl.dsp.window.move({ workspace = 10, follow = false }))   -- Numpad
hl.bind("SUPER + SHIFT + code:86", hl.dsp.window.move({ workspace = "+1", follow = false })) -- Numpad +
hl.bind("SUPER + SHIFT + code:82", hl.dsp.window.move({ workspace = -1, follow = false }))   -- Numpad -

-- Monitor control
hl.bind("SUPER + CONTROL + Left",
    function()
        local w = hl.get_active_workspace()
        if not w then return end
        hl.dispatch(hl.dsp.workspace.move({
            workspace = w.id,
            monitor = "l"
        }))
    end)
hl.bind("SUPER + CONTROL + Right",
    function()
        local w = hl.get_active_workspace()
        if not w then return end
        hl.dispatch(hl.dsp.workspace.move({
            workspace = w.id,
            monitor = "r"
        }))
    end)
hl.bind("SUPER + CONTROL + Up",
    function()
        local w = hl.get_active_workspace()
        if not w then return end
        hl.dispatch(hl.dsp.workspace.move({
            workspace = w.id,
            monitor = "u"
        }))
    end)
hl.bind("SUPER + CONTROL + Down",
    function()
        local w = hl.get_active_workspace()
        if not w then return end
        hl.dispatch(hl.dsp.workspace.move({
            workspace = w.id,
            monitor = "d"
        }))
    end)
