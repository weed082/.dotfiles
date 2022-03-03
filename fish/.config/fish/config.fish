set fish_greeting ""
set -gx TERM xterm-256color

set -x PATH $PATH /usr/local/go/bin
set -gx PATH $HOME/.cargo/bin $PATH

# -- theme --
set -g theme_display_git_default_branch yes
set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_color_scheme gruvbox
