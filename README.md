# My personal dotfiles used on my desktop and laptop

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

These dotfiles contain my shell, terminal emulator, window manager, bar and other
configuration files for Linux machines I use.

[Preview](https://www.reddit.com/r/unixporn/s/lNqgmmuw4d)

## Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Safety notes](#safety-notes)
- [License](#license)

> [!WARNING]
> **USE AT YOUR OWN RISK**
> These config files are tailored strictly to my personal preferences, machines
> and workflow. It is almost certain that they wont function correctly on your
> machine, especially regarding the .chezmoidata.toml file. Please proceed with
> caution before applying them to another system, especially if it's not linux.

## Features

- Bash and ZSH configuration (I use ZSH, bash is there just for compatibility's
  sake)
- Neovim configuration (Lazyvim based with a couple of personal tweaks)
- Kitty terminal configuration (based on
  [this](https://github.com/stefan-hacks/ikitty) amazing config)
- Window manager and compositor configuration (i3wm + picom with animations)
- Polybar and Rofi configuration (based on the amazing work by [adi1090x](https://github.com/adi1090x))
- Some basic git config
- Shell aliases and helper functions (some of them taken from [Chris's bashrc](https://github.com/ChrisTitusTech/mybash))
- And a lot of configs for many random tools that I use

## Requirements

- Linux
- Git
- [chezmoi](https://www.chezmoi.io/)
- Neovim
- Bash and/or Zsh

The rest of the tools is pretty much optional, although obviously if you don't
install it, the config won't work.

## Installation

Install chezmoi using your distribution's package manager or
the official installation instructions.

Then initialize these dotfiles:

```bash
chezmoi init --apply https://github.com/Brozi/dotfiles.git
```

During initialization, chezmoi may ask for values such as:

- Git email address
- Machine type: work or personal

Review the changes before applying them:

```bash
chezmoi diff
```

Apply the configuration:

```bash
chezmoi apply
```

## Safety Notes

Some aliases override basic linux commands, such as:

```bash
rm
cp
mv
mkdir
ls
vi
vim
```

Read 'dot_bashrc' or 'dot_config/zsh/dot_zshrc' before applying the configuration
to understand how those commands behave.

The chezmoi configuration (along with a neovim autocommand) may automatically
apply, add, commit and push
changes to github. Please verify whether this is a behavior you want, and change
it appropriately.

## License

This repository is primarily a personal configuration repository, and as such it
is provided "as-is" without any warranty. You are free to use, modify, and
distribute the contents of this repository for personal use.
