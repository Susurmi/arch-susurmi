#
# ~/.bash_profile
#

export PATH=/home/alex/.local/bin:$PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
  exec startx
fi