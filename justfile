os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

install-dependencies:
  #!/usr/bin/env bash
  if [ "{{os}}" = "Arch Linux" ]; then
    yay -S --needed ghostty
  fi

install: install-dependencies config

config:
  mkdir -p "{{home_dir()}}/.config/ghostty"
  stow -t "{{home_dir()}}/.config/ghostty" config
  dconf load / < gnome/terminal.conf

unset-config:
  stow -D -t "{{home_dir()}}/.config/ghostty" config
