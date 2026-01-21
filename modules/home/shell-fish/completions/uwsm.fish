# Fish completions for uwsm (Universal Wayland Session Manager)

# --- Helper Functions ---

# Dynamically find .desktop files in wayland-sessions folders
function __fish_complete_uwsm_get_sessions
    # Standard XDG Data locations
    set --local paths (string split ":" "$XDG_DATA_DIRS")
    if test -z "$paths"
        set paths /usr/local/share /usr/share
    end

    # Add user local data path
    set --local user_data_home "$XDG_DATA_HOME"
    if test -z "$user_data_home"
        set user_data_home "$HOME/.local/share"
    end
    set --append paths "$user_data_home"

    for path in $paths
        set --local session_dir "$path/wayland-sessions"
        if test -d "$session_dir"
            for file in "$session_dir"/*.desktop
                if test -f "$file"
                    basename "$file"
                end
            end
        end
    end | sort -u
end

# Check if we are at the first positional argument after the subcommand
function __fish_complete_uwsm_is_first_pos_arg
    set --local cmd (commandline -opc)
    set --erase cmd[1] # remove 'uwsm'

    # Remove the subcommand itself
    if test (count $cmd) -gt 0
        set --erase cmd[1]
    end

    # Count how many arguments are NOT flags
    set --local count 0
    for arg in $cmd
        if not string match -q -- "-*" "$arg"
            set count (math $count + 1)
        end
    end

    # If 0 non-flag args exist, the next one is the first positional arg
    test $count -eq 0
end

set --local subcommands select start stop finalize app check aux

complete -c uwsm --no-files -d 'Universal Wayland Session Manager'

# --- Global Options ---
complete -c uwsm -n "not __fish_seen_subcommand_from $subcommands" -s h -l help -d 'Show help'
complete -c uwsm -n "not __fish_seen_subcommand_from $subcommands" -s v -l version -d 'Print version'

# --- Subcommands ---
complete -c uwsm -n "not __fish_seen_subcommand_from $subcommands" -a select -d 'Select default compositor entry'
complete -c uwsm -n "not __fish_seen_subcommand_from $subcommands" -a start -d 'Start compositor'
complete -c uwsm -n "not __fish_seen_subcommand_from $subcommands" -a stop -d 'Stop compositor'
complete -c uwsm -n "not __fish_seen_subcommand_from $subcommands" -a finalize -d 'Export variables and notify systemd'
complete -c uwsm -n "not __fish_seen_subcommand_from $subcommands" -a app -d 'Application unit launcher'
complete -c uwsm -n "not __fish_seen_subcommand_from $subcommands" -a check -d 'Performs state checks'
complete -c uwsm -n "not __fish_seen_subcommand_from $subcommands" -a aux -d 'Auxiliary functions'

# --- Subcommand: start ---
complete -c uwsm -n "__fish_seen_subcommand_from start" -s h -l help -d 'Show help'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s D -d 'XDG_CURRENT_DESKTOP names'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s a -d 'Append desktop names'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s e -d 'Use desktop names exclusively'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s N -d 'Fancy name'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s C -d 'Fancy description'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s U -x -a "run home" -d 'Unit destination'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s t -d 'No tweak drop-ins'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s T -d 'Generate tweak drop-ins'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s F -d 'Hardcode command line'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s g -d 'Wait for graphical.target (warn)'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s G -d 'Wait for graphical.target (abort)'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s o -d 'Only generate units'
complete -c uwsm -n "__fish_seen_subcommand_from start" -s n -d 'Dry run'

# Positional arguments for start (Session IDs)
complete -c uwsm -n "__fish_seen_subcommand_from start; and __fish_complete_uwsm_is_first_pos_arg" -a "select default" -d 'Special ID'
complete -c uwsm -n "__fish_seen_subcommand_from start; and __fish_complete_uwsm_is_first_pos_arg" -a "(__fish_complete_uwsm_get_sessions)" -d 'Session Entry'

# --- Subcommand: stop ---
complete -c uwsm -n "__fish_seen_subcommand_from stop" -s h -l help -d 'Show help'
complete -c uwsm -n "__fish_seen_subcommand_from stop" -s r -x -a "tweaks generic" -d 'Remove specific unit files'
complete -c uwsm -n "__fish_seen_subcommand_from stop" -s U -x -a "run home" -d 'Unit destination'
complete -c uwsm -n "__fish_seen_subcommand_from stop" -s n -d 'Dry run'

# --- Subcommand: finalize ---
complete -c uwsm -n "__fish_seen_subcommand_from finalize" -s h -l help -d 'Show help'

# --- Subcommand: app ---
complete -c uwsm -n "__fish_seen_subcommand_from app" -s h -l help -d 'Show help'
complete -c uwsm -n "__fish_seen_subcommand_from app" -s s -x -a "a b s" -d 'Slice (app, background, session)'
complete -c uwsm -n "__fish_seen_subcommand_from app" -s t -x -a "scope service" -d 'Unit type'
complete -c uwsm -n "__fish_seen_subcommand_from app" -s S -x -a "out err both" -d 'Silence output'
complete -c uwsm -n "__fish_seen_subcommand_from app" -s T -d 'Launch in terminal'
complete -c uwsm -n "__fish_seen_subcommand_from app; and __fish_complete_uwsm_is_first_pos_arg" -f -a "(__fish_complete_path)"

# --- Subcommand: check ---
complete -c uwsm -n "__fish_seen_subcommand_from check" -f -a "is-active may-start"

# --- Subcommand: aux ---
complete -c uwsm -n "__fish_seen_subcommand_from aux" -f -a "prepare-env cleanup-env exec waitpid waitenv app-daemon"
