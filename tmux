# List of plugins
set -g default-terminal "screen-256color"

set -g prefix C-a

bind s choose-tree -sZ -O name

set -g base-index 1
set -g pane-base-index 1

unbind %
bind | split-window -h

unbind '"'
bind - split-window -v

unbind r
bind r source-file ~/.tmux.conf

bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5
bind -r h resize-pane -L 5

bind -r m resize-pane -Z

set -g mouse on

set-window-option -g mode-keys vi

bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection

unbind -T copy-mode-vi MouseDragEnd1Pane

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'christoomey/vim-tmux-navigator'
 set -g @plugin 'jimeh/tmux-themepack'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'tmux-plugins/tmux-sessionist'

 set -g @themepack 'powerline/default/blue'

set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-restore 'on'

run '~/.tmux/plugins/tpm/tpm'
