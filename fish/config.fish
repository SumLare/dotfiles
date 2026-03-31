# disable greeting
set fish_greeting

/opt/homebrew/bin/brew shellenv | source

fish_add_path $HOME/bin

if status is-interactive
    starship init fish | source

    # Ctrl+F to accept autosuggestion in vi mode
    bind -M insert \cf forward-char
end
