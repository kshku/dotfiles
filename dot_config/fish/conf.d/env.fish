# Environment settings shared across machines via chezmoi.
# Fish-native equivalent of ~/.my.profile (used by zsh/bash shells).

# VLC crashes on NVIDIA. To fix it set the environment variable.
if test -d /proc/driver/nvidia
    set -gx LIBVA_DRIVER_NAME nvidia
end

if test -d /usr/local/lib/pkgconfig
    set -gx PKG_CONFIG_PATH /usr/local/lib/pkgconfig $PKG_CONFIG_PATH
end

alias la='ls -a'

if test -d "$HOME/Android/Sdk"
    set -gx ANDROID_HOME "$HOME/Android/Sdk"
    set -gx PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools
end

if test -d "$HOME/go/bin"
    set -gx PATH $PATH $HOME/go/bin
end

if command -v uv >/dev/null 2>&1
    uv generate-shell-completion fish | source
end
