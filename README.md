Dotfiles
---------

These are the dotfiles belonging to me, Ben. They are organized into a few folders.
  * `home` is for things that go in my home directory.
  * `scripts` go into my local bin, usually `~/.local/bin`.
  * `web` is used for config files and a home page for web browsing.
  * `dwm` is the config.h file for my window manager, of choice, dwm.

You can install these files by running `./dotproduct.rb config.yml`.
This will use the information stored in `config.yml` to place the files
in your home directory.

The program `dotproduct` doesn't just copy files. It also will interpolate
certain strings found within my configuration files. The different
variables that are interpolated are defined in `config.yml`. The delimiter
used is specified for each entry in `config.yml`.
