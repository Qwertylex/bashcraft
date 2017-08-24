bashcraft
=========

bashcraft is a minimal Minecraft launcher and updater, written in pure Bash, for use under Linux, Mac OS X and Solaris.

Usage
-----

```
bashcraft.sh [--force-update] [--remove-prefs] [--change-prefs] [--help]
```

### Options ###
* `--force-update`: Force an update of Minecraft, overwriting the existing minecraft.jar and associated files
* `--remove-prefs`: Removes the preferences file.
* `--change-prefs`: Prompts for a new username and password and stores it in the preferences file.
* `--help`: Provide a brief help message.

File locations
--------------

`bashcraft.sh` can be placed anywhere, but it will store Minecraft and it's preferences under a set location, determined by platform:

* **Linux and Solaris:** `~/.minecraft`
* **Mac OS X:** `~/Library/Application Support/minecraft`

Preferences
-----------

The preference file, `bashcraft-prefs`, is stored in the same directory as the Minecraft installation, which varies by platform (see above). 
The preference file is a Bash script, which is sourced at runtime before starting Minecraft. 
It can contain any commands you wish to run before Minecraft starts, as well as the following configuration options:

* `username="..."`: The Minecraft username you wish to use
* `password="..."`: The password to the Minecraft account specified in `username`. Not required if you wish to play offline.
* `MCoptions="..."`: Any options you wish to pass to Minecraft can be specified here.

Screenshot
----------

bashcraft is a command-line program, but have a screenshot anyway:

![bashcraft screenshot, showing the OS detection and the interface to set the Minecraft username and password.](http://i.imgur.com/EGTZZ.png)

Licence
-------

bashcraft is licenced under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit [http://creativecommons.org/licenses/by-sa/3.0/](http://creativecommons.org/licenses/by-sa/3.0/).

Authors
-------

bashcraft has had contributions from the following people:

* [Alex](https://github.com/Qwertylex)
* [Alice Jenkinson](https://github.com/0x52a1) <[0x52a100ff@gmail.com](mailto:0x52a100ff@gmail.com)>
