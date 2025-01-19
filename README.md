DJ Overlay
==========

Good news everyone, I was added between Gentoo repositories, so all you need to do is:
```sh
sudo eselect repository enable djs_overlay
sudo emaint sync -r djs_overlay
```

Some packages which I am using and ebuild didn't existed at that time. Feel free to use it and report bugs.

I must say, that I am still beginner doing these, so the quality will not be any good, but since I am using them it should work.

- **Cinnamon** - I wanted to try new version of Cinnamon so I just coppied all old ebuild with new version, it worked, somehow, but needed some other dependencies. Some are version bumps, others I had to borrow from [pg_overlay](https://github.com/gentoo-mirror/pg_overlay), [Miezhiko](https://github.com/gentoo-mirror/Miezhiko). I hope authors will not get mad (still have to find how this is solved properly, I had added them to be in the same repository, otherwise you would have to add both of them as well but all credits for them are **theirs**, not mine). My changes can make your Gnome unstable so if you want the correct version of Gnome, please go to Miezhiko overlay, add it in into Gentoo by eselect repository and then install Cinnamon from my.

And one more thing I had raised a ticket to be added into eselect repository list, I will add this information how to add me properly using Gentoo's default tools.

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
- **dev-libs/fuzzylite** - It seems, that this package is not needed in VCMI compilation, GIT version downloads it, for normal version it needs to be downloaded, but I will keep it here, if someone uses it,

### dev-util
- **sysprof** - Dependency for Cinnamon (just version bump)
- **sysprof-capture** - Dependency for Cinnamon (just version bump)
- **sysprof-common** - Dependency for Cinnamon (just version bump)

### games-engines
- **[TheForceEngine](https://github.com/luciusDXL/TheForceEngine)** - The force engine which is able to run [Dark Forces (1995)](https://www.gog.com/en/game/star_wars_dark_forces), and [Outlaws (1997)](https://www.gog.com/en/game/outlaws_a_handful_of_missions). You need original game to use this engine. Also DREAMM is able to run these games, but this is engine recreation, which might have some additional options (e.g. like OpenTTD, I haven't tried it yet)

### games-strategy
  - **[vcmi](https://github.com/vcmi/vcmi)** - HOMAM3 game engine. Well, I made my efford just to find, version 1.6.0 was released, so I deleted patches and copied the same ebuild and it seems to compile and VCMI is not segfaulting

### gnome-extra
- **[cinnamon](https://github.com/linuxmint/cinnamon)** - Cinnamon (just version bump)
- **[cinnamon-control-center](https://github.com/linuxmint/cinnamon-control-center)** - Cinnamon control center (just version bump)
- **[cinnamon-desktop](https://github.com/linuxmint/cinnamon-desktop)** - Cinnamon desktop (just version bump)
- **[cinnamon-menus](https://github.com/linuxmint/cinnamon-menus)** - Cinnamon menus (just version bump)
- **[cinnamon-screensaver](https://github.com/linuxmint/cinnamon-screensaver)** - Cinnamon screensaver (just version bump)
- **[cinnamon-session](https://github.com/linuxmint/cinnamon-session)** - Cinnamon session (just version bump)
- **[cinnamon-settings-daemon](https://github.com/linuxmint/cinnamon-settings-daemon)** - Cinnamon settings daemon (just version bump)
- **[cinnamon-translations](https://github.com/linuxmint/cinnamon-translations)** - Cinnamon translations (just version bump)
- **[cjs](https://github.com/linuxmint/cjs)** - Linux Mint's fork of gjs for Cinnamon (just version bump)
- **[nemo](https://github.com/linuxmint/nemo)** - A file manager for Cinnamon, forked from Nautilus (just version bump)

### gui-libs
- **[gtk](https://gitlab.gnome.org/GNOME/gtk/)** - Cinnamon required version, all credits for ebuild goes to [pg_overlay](https://github.com/gentoo-mirror/pg_overlay)
- **[libadwaita](https://gitlab.gnome.org/GNOME/libadwaita)** - Cinnamon required version, all credits for ebuild goes to [Miezhiko](https://github.com/gentoo-mirror/Miezhiko)
- **[libpanel](https://gitlab.gnome.org/GNOME/libpanel)** - Cinnamon required version (just version bump)

### media-libs
- All packages are Cinnamon prerequisity, all credits for ebuilds goes to [Miezhiko](https://github.com/gentoo-mirror/Miezhiko)

### media-plugins
- All packages are Cinnamon prerequisity, all credits for ebuilds goes to [Miezhiko](https://github.com/gentoo-mirror/Miezhiko)

### media-video
- **[bcwc_pcie](https://github.com/wackywendell/bcwc_pcie)** - Prerequisity for Macbook's facetime camera to work,
- **[facetimehd-firmware](https://github.com/patjak/facetimehd)** - Firmware for Macbook's facetime camera to work,

### net-wireless
- **broadcom-wl** - Taken from 4nykey overlay, but had to create patch for 6.12 kernel, seems some includes had changed and it would not compile

### www-client
- **[brave-bin](https://github.com/brave/brave-browser)** - [Brave](https://brave.com/) browser

### x11-libs
- **[pango](https://gitlab.gnome.org/GNOME/pango)** - Dependency for GTK 4.17.3, version bump from Gentoo overlay

### x11-misc
- **[albert](https://github.com/albertlauncher/albert)** - Another launcher (Qt dependencies)
- **[touchegg](https://github.com/JoseExposito/touchegg)** - Gesture library, I was used to MacOS gestures and it seems, that this one works as I want,
- **[ulauncher](https://ulauncher.io/)** - MacOS Spotlight replacement and pretty good (GTK dependencies),

### x11-terms
- **[termius](https://support.termius.com/hc/en-us/articles/4404036107673-Windows-Linux-Mac)** - [Termius](https://termius.com) SSH/SFTP client,
- **[tilda](https://github.com/lanoxx/tilda)** - Guake-like terminal, just testing it.

### X11-wm
- **[muffin](https://github.com/linuxmint/muffin)** - Cinnamon required version (just version bump)
