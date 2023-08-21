# emacs 29 users

[click here](https://github.com/orzechowskid/duomacs/tree/main)

# duomacs
dan's usability-oriented Emacs config files

![](https://repository-images.githubusercontent.com/505004456/7184cf38-0cf0-4cf3-bb65-aaeae37d526e)

## What is it

it's emacs for people new to emacs.  an opinionated set of config files which aim to bring extra consistency, familiarity, and discoverability to the stock emacs experience.  there are some extra goodies related to the major modes I use most often for personal and work projects (Typescript) but otherwise it's pretty barebones.

### What is it really

it's emacs, but with:
- use-package and straight.el for package management
- cua-mode for keybindings which make sense to the rest of the world
- consult, corfu, and marginalia for completing read, incremental narrowing, list sorting, etc
- a custom menu bar, disabled tool-bar, and heavily delight'd modeline for getting rarely-used junk out of the user's face
- vscode-like light and dark themes for a look and feel that doesn't party like it's 1989

if you know what all of that stuff means, then this set of config files is probably not for you!  you likely already know how to configure emacs to your liking.

## Installation

### The easy way

clone this repository and symlink `duomacs-early-init.el` and `duomacs-init.el` into your `~/.emacs.d` directory as `early-init.el` and `init.el` respectively

### The other easy eay

clone this repository and add `(load-file "<path/to/duomacs/duomacs-init.el>")` somewhere to your existing init file

### The hard way

copy whatever you want from the various source files into your own init file.  go nuts!

## Configuration

the only custom configuration option exposed by duomacs is `duomacs-theme`; all other features are controlled by, and configured via, the packages which provide them.  no layers, no duomacs-specific macros, just plain vanilla emacs.  an exhaustive list of the packages which power duomacs can be found by running `git grep -A 1 use-package` in your favorite shell, but here are some of the important ones:

- [consult](https://github.com/minad/consult)
- [corfu](https://github.com/minad/corfu)
- [eglot](https://github.com/joaotavora/eglot)
- [magit](https://magit.vc/)
- [orderless](https://github.com/oantolin/orderless)
- [vertico](https://github.com/minad/vertico)

you can configure these packages (as well as any other built-in or third-party emacs feature) by selecting an item in the Options menu, or by entering `M-x customize-` and choosing one of the items in the resulting list.
