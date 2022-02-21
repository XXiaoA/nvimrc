require"termwrapper".setup {
    -- these are all of the defaults
    open_autoinsert = true, -- autoinsert when opening
    toggle_autoinsert = true, -- autoinsert when toggling
    autoclose = true, -- autoclose, (no [Process exited 0])
    winenter_autoinsert = false, -- autoinsert when entering the window
    default_window_command = "belowright 13split", -- the default window command to run when none is specified,
                                                   -- opens a window in the bottom
    open_new_toggle = true, -- open a new terminal if the toggle target does not exist
    log = 1, -- 1 = warning, 2 = info, 3 = debug
}
