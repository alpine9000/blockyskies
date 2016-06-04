# BLOCKY SKIES AMIGA 2016

For full copyright information see [here](http://alpine9000.github.io/blockyskies/LEGAL.html)

## About

This was my first attempt at a game for classic Amiga.

The goal was a game that would run on a 68000 Amiga with only 512kb of ram.

In order to actually get something finished in a reasonable timeframe, I banned refactoring unless the frame rate fell below 50fps or the code compromised the game.  This rule has resulted in some quite hard to understand routines :-) but I did get something finished in a reasonable timeframe. In around 8 weeks of working a handful of hours a week a basic game was ready.

## Amiga

This game uses lots of Amiga hardware features:

* Independently scrolling dual playfields.
* The blitter is used everywhere (probably in some cases where it should not be)
* The copper is used extensively. In the main game screen it switches screen modes mid screen and changes the palette 6 times.
* Sprites are used for all of the items on the board.
* 3 audio channels are used for the music soundtrack and 1 channel is used for SFX.
* A hardware track loader (thanks to Photon/Scoopex) is used to load data directly from the floppy.

## 68000

Veteran 68000 programmers will be able to tell that my 68000 experience is limited.  For the most part I was able to write this game using only a small subset of available 68000 instructions.

## Cross Development

The game was cross developed on a mac using vasm and vlink as well as a handful of custom tools that I wrote for preparing Amiga data.

I made extensive use of my [hacked version of FS-UAE](https://github.com/alpine9000/fs-uae) that allowed me to use the FS-UAE debugger with access to my programs symbols even after booting from the bootblock.

For details on setting up the cross development environment see [here](game/docs/BuildingCrossDev.md)





