# emacs 30 users

```
$ git clone -b emacs-30 https://github.com/orzechowskid/duomacs.git
```

complete instructions: [click here](https://github.com/orzechowskid/duomacs/tree/emacs-30)

# emacs 29 users

```
$ git clone -b emacs-29 https://github.com/orzechowskid/duomacs.git
```

complete instructions: [click here](https://github.com/orzechowskid/duomacs/tree/emacs-29)


# emacs 28 users

```
$ git clone -b emacs-28 https://github.com/orzechowskid/duomacs.git
```

complete instructions: [click here](https://github.com/orzechowskid/duomacs/tree/emacs-28)

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
- a custom menu bar, disabled tool-bar, and heavily delight'd modeline for getting rarely-used junk out of the user's face
- light and dark nord-based themes for a look and feel that doesn't party like it's 1989

if you know what all of that stuff means, then this set of config files is probably not for you!  you probably already know how to configure emacs to your liking.

## Installation

in general, all you should need to do is `git clone` this repository, `git checkout` the branch most compatible with your version of emacs (v28 and newer are supported), then symlink duomacs-early-init.el and duomacs-init.el into your ~/.emacs.d directory as early-init.el and init.el respectively.  for complete installation instructions, and much more, visit one of the links at the top of this file and see the README for that branch.

## License

GPL 3.0
