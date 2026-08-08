source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
status is-interactive; and pyenv init --path | source
status is-interactive; and pyenv init - | source
