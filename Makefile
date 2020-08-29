SERVICE := /etc/systemd/system/ppsmon.service
PPSMON := /usr/bin/ppsmon

all:
	@echo "Please choose one of the targets"
	@echo "  system: Install the ppsmon systemd file and ppsmon executable on the system"
	@echo "  ohmyzsh: Install the oh-my-zsh theme and activate it in ~/.zshrc"
	@echo "  bash: Copy the bash.prompt file to ~/.pps.bashrc, you will need to manually activate it"
	@echo "  zsh: Copy the zsh.prompt file to ~/.pps.zshrc, you will need to manually activate it"


system: $(SERVICE)

/usr/bin/ppsmon:
	sudo install usr/bin/ppsmon /usr/bin -m 755 -o root -g root

$(SERVICE): $(PPSMON)
	@echo -n Enter to continue, this will install the systemd file and the daemon system-wide ...
	@read ok
	sudo install etc/systemd/system/ppsmon.service /etc/systemd/system/ -m 644 -o root -g root
	sudo systemctl daemon-reload
	sudo systemctl start ppsmon	

~/.oh-my-zsh:
	@echo -n 'Press enter to install oh-my-zsh package from maintainer site ...'
	@read ok
	@sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ohmyzsh: $(SERVICE) ~/.oh-my-zsh
	install ppsmon.zsh-theme ~/.oh-my-zsh/themes/ -m 644
	@echo 'Theme installed, please set ZSH_THEME="ppsmon" in ~/.zshrc'


bash: $(SERVICE)
	cp bash.prompt ~/.pps.bashrc
	@echo 'Installed file, please configure your ~/.bashrc or ~/.bash_profile to use ~/.pps.bashrc'

zsh: $(SERVICE)
	cp zsh.prompt ~/.pps.zshrc
	@echo 'Installed file, please configure your ~/.bashrc or ~/.bash_profile to use ~/.pps.bashrc'
