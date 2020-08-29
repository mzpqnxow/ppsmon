# Derived from the aussiegeek theme, modified to include packet transmit rate from ppsmon
# - mzpqnxow@github
PROMPT='$fg_bold[green]TX PPS:($(cat /dev/shm/ppsmon/tx-pps)) RX PPS:($(cat /dev/shm/ppsmon/rx-pps))
$fg_bold[blue][$fg[red]%t $fg_bold[blue]] $fg_bold[blue] [ $fg[red]%n@%m:%~$(git_prompt_info)$fg[yellow]$(rvm_prompt_info)$fg_bold[yellow] $fg_bold[blue] ]$reset_color
$ '
# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="$fg_bold[green]("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_CLEAN="✔"
ZSH_THEME_GIT_PROMPT_DIRTY="✗"
