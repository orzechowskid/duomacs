# emacs 28 and 29 users

[click here](https://github.com/orzechowskid/duomacs/tree/emacs-28)

# duomacs
dan's usability-oriented Emacs config files

![image](https://repository-images.githubusercontent.com/505004456/eec4ea76-ac91-4ead-a795-d51d4c8750b0)

## What is it

it's emacs for people new to emacs.  an opinionated set of config files which aim to bring extra consistency, familiarity, and discoverability to the stock emacs experience.  there are some extra goodies related to the major modes I use most often for personal and work projects (Typescript) but otherwise it's pretty barebones.

### What is it really

it's emacs, but with:
- use-package and straight.el for package management
- cua-mode for keybindings which make sense to the rest of the world
- consult, vertico, orderless, corfu, and marginalia for enhancing emacs' built-in completing-read, incremental narrowing, list sorting, etc
- embark for keyboard-controlled context-menu functionality
- disabled tool-bar and heavily delight'd modeline for getting rarely-used junk out of the user's face
- 
- Nord-like light and dark themes (optionally configured to follow your OS' light/dark settings) for a look and feel that doesn't party like it's 1989

if you know what all of that stuff means, then this package is probably not for you since you probably already know how to configure emacs to your liking.

## Installation

### The easy way

clone this repository and symlink `duomacs-early-init.el` and `duomacs-init.el` into your `~/.emacs.d` directory as `early-init.el` and `init.el` respectively

### The other easy eay

clone this repository and add `(load-file "<path/to/duomacs/duomacs-init.el>")` somewhere to your existing init file

### The manual way

copy whatever you want from the various source files into your own init file.  go nuts!  I've tried my best to limit the number of dependencies between files in this package so it should be pretty safe to copy/paste willy-nilly but it's very possible I've forgotten to wrap something or other inside of `boundp`.  please file a bug if this happens to you.

## Configuration

| Variable                   | Purpose                           |
| --                         | --                                |
| `duomacs-show-menu-bar`    | show/hide menu bar                |
| `duomacs-theme`            | use a specific duomacs theme      |
| `duomacs-use-system-theme` | use OS' preferred light/dark mode |

all other features are controlled by, and configured via, the packages which provide them.  no layers, no duomacs-specific macros, just plain vanilla emacs.  an exhaustive list of the packages which power duomacs can be found by running `git grep "(use-package "` in your favorite shell, but here are some of the important ones:

- [consult](https://github.com/minad/consult)
- [corfu](https://github.com/minad/corfu)
- [magit](https://magit.vc/)
- [orderless](https://github.com/oantolin/orderless)
- [vertico](https://github.com/minad/vertico)

you can configure these packages (as well as any other built-in or third-party emacs feature) by selecting an item in the Options menu, or by entering `M-x customize-` and choosing one of the items in the resulting list.
