_virtualenv_auto_activate() {
    # Assuming vitualenv is always named venv
    if [ -e "venv" ]
    then
        # Check if already activated to avoid redundant activation.
        if [ -z "$VIRTUAL_ENV" ]
        then
            source "venv/bin/activate"
        fi
    else
        deactivate 2>/dev/null
    fi
}

# Execute given function if derectory changed.
# Unlike in Zsh's "chpwd_functions" won't work with "cd .".
_bash_chpwd_function() {
    if [ "$PWD" != "$_myoldpwd" ]
    then
        _myoldpwd="$PWD";
        $1
    fi
}


unset VIRTUAL_ENV # Before activation remove VIRTUAL_ENV from inherited env.

chpwd_functions=(_virtualenv_auto_activate) # Activate on directory change.
