DJ Overlay
==========

Some packages which I am using and ebuild didn't existed at that time. Feel free to use it and report bugs.

I must say, that I am still beginner doing these, so the quality will not be any good, but since I am using them it should work.

## Packages

### acct-group
- **[keyd](https://github.com/rvaiya/keyd)** - Group for keyd daemon,

### app-editors
- **[sublime-text-dev](https://www.sublimetext.com/dev)** - Only for users with Sublime license. It gets installed in the same location as app-editors/sublime-text so these two packages should not coexist on same system (at the moment). I separated them, because I am using it for python development and needed dev-libs/nodejs with npm flag as dependency so I had finally did half separation (package name, but not install location),

### app-emulators
- **[dreamm](https://aarongiles.com/dreamm/)** - I like this simple emulator for old Lucas Arts games. For most of them there is [ScummVM](https://scummvm.org/), which is allready in official Gentoo repository, but some games, e.g. Yoda Storries, Indiana Jones storries which are not so good are playable throught this,

### app-misc
- **[keyd](https://github.com/rvaiya/keyd)** - Daemon, which is able to remap keys. I am using it on MacBook to map CMD as CTRL as in Mac OS you use CMD most (as on Linux/Windows CTRL key does). The main reason I like this daemon is, that its system wide so regardless of DE or plain CLI interface, keyboard behaves the same,

### dev-db
- **[dbGate](https://dbgate.org/)** - The Smartest SQL+noSQL Database Client,

### dev-libs
- **dev-libs/fuzzylite** - Dependency for VCMI,

### games-strategy
- **[vcmi](https://github.com/vcmi/vcmi)** - HOMAM3 game engine. I like HOMMAM games and there was no good ebuild so I had tried to do my own. This one is for the version git tag 1.5.7 and it downloads everything from git and builds. When the branch is updated, it has to be rebuild again. I might try to find way how to do it correctly so it gets self updated. But still more advanced, than my skills are,

### mate-base
- **[mate-panel](https://github.com/mate-desktop/mate-panel)** - I had problems with official version 1.28.1, that sometimes when I was switchin apps it froze. I did version bump and it is better, but TBH, still not skilled enough to update main gentoo repo, maybe in future, 

### media-video
- **[bcwc_pcie](https://github.com/wackywendell/bcwc_pcie)** - Prerequisity for Macbook's facetime camera to work,
- **[facetimehd-firmware](https://github.com/patjak/facetimehd)** - Firmware for Macbook's facetime camera to work,

### www-client
- **[brave-bin](https://brave.com/)** - Brawe browser,

### x11-misc
- **[touchegg](https://github.com/JoseExposito/touchegg)** - Gesture library, I was used to MacOS gestures and it seems, that this one works as I want,
- **[ulauncher](https://ulauncher.io/)** - MacOS Spotlight replacement and pretty good,

### x11-terms
- **[termius](https://termius.com/)** - Termius SSH/SFTP client,
- **[tilda](https://github.com/lanoxx/tilda)** - Guake-like terminal, just testing it.
