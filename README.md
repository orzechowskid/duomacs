# emacs 28 users

[click here](https://github.com/orzechowskid/duomacs/tree/main)

# duomacs
dan's usability-oriented Emacs config files

![image](https://user-images.githubusercontent.com/2667110/210151620-fcea8933-6ad4-481b-89ac-bc88d079b475.png)

## What is it

it's emacs for people new to emacs.  an opinionated set of config files which aim to bring extra consistency, familiarity, and discoverability to the stock emacs experience.  there are some extra goodies related to the major modes I use most often for personal and work projects (Typescript) but otherwise it's pretty barebones.

### What is it really

it's emacs, but with:
- use-package and straight.el for package management
- cua-mode for keybindings which make sense to the rest of the world
- consult, vertico, orderless, corfu, and marginalia to enhance emacs' built-in completing-read, incremental narrowing, list sorting, etc
- a custom menu bar, disabled tool-bar, and heavily delight'd modeline for getting rarely-used junk out of the user's face
- a nord theme and vscode-like light and dark themes for a look and feel that doesn't party like it's 1989

if you know what all of that stuff means, then this set of config files is probably not for you!  you probably already know how to configure emacs to your liking.

## Installation

### The easy way

clone this repository and symlink `duomacs-early-init.el` and `duomacs-init.el` into your `~/.emacs.d` directory as `early-init.el` and `init.el` respectively

### The other easy eay

clone this repository and add `(load-file "<path/to/duomacs/duomacs-init.el>")` somewhere to your existing init file

### The hard way

copy whatever you want from the various source files into your own init file.  go nuts!
