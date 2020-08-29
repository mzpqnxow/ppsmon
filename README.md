# ppsmon: Simple service to track packet per second rate so it can be used in shell prompts

`ppsmon` is a very simple service that reads `/sys/class/net/$interface/` to keep track of packet transmission rates. It stores the current rate to a file in the RAM backed filesystem where it can be easily accessed for display in a shell-prompt. This is nothing special and is quite simple- the "service" is about 15 lines of bash, an infinite loop that reads from `/sys` to get basic statistics

## Prerequisites

* Linux (because of the use of the `/sys` filesystem)
* [oh-my-zsh](https://ohmyz.sh/) (if you want to use the canned `ppsmon.zsh-theme` file)
* bash (if you want to use the bash prompt file)
* zsh (if you want to use the vanilla zsh prompt file)
* The `nobody` and `nogroup` user and group
* A network interface named `eth0`

If you want to change the network interface or the `nobody`/`nogroup` user to some other value, you can edit the etc/systemd/system/ppsmon.service file with minimal effort before installing

## Caveats

First, be aware that it is possible that this service could be abused to potentially write the packet rate integer to an arbitrary location on the filesystem, though it doesn't seem clear that this is the case- just fair warning. This is a theoretical concern that I haven't looked too deeply into as it is mitigated significantly by the fact that only an uncontrolled integer value can be written and it can only be written with the privileges of the `nobody` user

## Installation

You can manually copy the files into place or you can use the provided `Makefile` to make things quicker and less clunky

### Makefile

`make ohmyzsh`: This will install the oh-my-zsh theme into your home directory oh-my-zsh installation
`make bash`: This will install the Bash prompt file into your home directory into ~/.pps.prompt
`make zsh`: This will install the zsh prompt file into your home directory into ~/.zsh.prompt
`make system`: This will install the daemon into /usr/bin and the systemd service file into /etc/systemd/system

If the service file is not present, any of the `Makefile` targets will install it for you with a confirmation prompt

## Post-Installation

* For oh-my-zsh, you will need to set `ZSH_THEME=ppsmon` in your `~/.zshrc`
* For bash, you will need to add `source ~/.pps.bash` to your `~/.bashrc` or `~/.bash_profile`
* For zsh, you will need to add `source ~/.pps.zshrc` to your `~/.zshrc`

For bash and zsh, make sure that you source the file last in your settings or the prompt may get overwritten by other rc scripts

### As a user service instead of a system service

It may make more sense to have this as a user service in many cases, rather than a system-wide service. This depends on your configuration

## Copyright

* copyright@mzpqnxow.com, BSD 3-Clause License
* See COPYING
* That's right, I just copyrighted 15 lines of bash script