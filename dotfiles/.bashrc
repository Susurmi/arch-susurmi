#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$'

alias la='ls -lA'
alias vup='wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+'
alias vdown='wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-'
alias vmute='wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
alias mmute='wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'
alias volume='wpctl get-volume @DEFAULT_AUDIO_SINK@'