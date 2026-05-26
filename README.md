# README

2026-05-26
    - moved over to sway.
        - we'll find out if this is an issue when I do multi monitors
    - no longer need picom
    - no longer need i3

## st

- remove the default config.def.h
- paste in mine
- make clean && sudo make install
- uses monospace default and just changes some colors around
- had some strange alacritty problems where it died for no apparent reason
- I think it's bc of graphics. st is just less moving parts

## mozilla

- add to .config/mozilla/<user-profile>/chrome/userprefcssstuff

## uses

> just keeping track of things that I use so I can install in the future

- sway --unsupported-gpu as Exec=
    - need to create and put into /usr/local/share/wayland-sessions/sway.desktop 
    - from /usr/share/wayland-sessions/sway.desktop 
- bemenu
- wayland
