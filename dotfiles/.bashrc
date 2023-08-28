#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\033[01;34m\]\w \033[00m\]-> '

alias ll='ls -lA --color=auto'

alias sysupdate="sudo pacman -Syyu"

alias vup='wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+'
alias vdown='wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-'
alias vmute='wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
alias mmute='wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'
alias volume='wpctl get-volume @DEFAULT_AUDIO_SINK@'

alias ttc="sh '/home/alex/.local/share/Steam/steamapps/compatdata/306130/pfx/drive_c/users/steamuser/Documents/Elder Scrolls Online/live/AddOns/Linux Tamriel Trade Center/Scripts/5-mins-looping-scripts/TTCLO-LINUX-STEAM-V2.2-EU.sh'"

alias obsync="rclone sync /home/alex/Dokumente/obsidian/Notizen/ Dropbox:Apps/Obsidian/Notizen -v -P"
alias obfetch="rclone sync Dropbox:Apps/Obsidian/Notizen /home/alex/Dokumente/obsidian/Notizen -v -P"
alias obbackup="rclone sync /home/alex/Dokumente/obsidian/ Dropbox:Obsidian -v -P"