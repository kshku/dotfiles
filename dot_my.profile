# VLC crashes for some reason. To fix it set the environment variable
export LIBVA_DRIVER_NAME=nvidia

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

alias la='ls -a'

# [ -d "$HOME/Dev/flutter/bin" ] && export PATH="$HOME/Dev/flutter/bin:$PATH"

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$HOME/go/bin"

if command -v pyenv 1>/dev/null 2>&1
then
    #export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init - zsh)"
fi

if command -v uv 1>/dev/null 2>&1
then
    eval "$(uv generate-shell-completion $(basename $SHELL))"
fi
