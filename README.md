# Csőamőba

This board game is a variant of the well-known [Connect 4](https://en.wikipedia.org/wiki/Connect_Four).
It was written in Hungarian back in the nineties by Csaba Biró and Zoltán Kovács.

## Prerequisites

You need a Linux desktop system. The current version was tested on Ubuntu 22.04.
You also need the following packages:

* a C compiler (the package `build-essential` should be fine),
* the XForms library (the package `libforms-dev` should work).

## Compilation

Run the script `./FORDIT`.

## Starting the program

* Run the executable `./Csoamoba`.
* Click on the first button on the splash screen.
* Set "Legyen zenei aláfestés?" to "Inkább ne". Otherwise expect a crash sooner or later.
* Click on "Start gáme".
* Point the mouse on the bottom row of the selected column.

## Disappointed? Use a former version!

This version is a work in progress. Come back later or visit a [web page](https://matek.hu/zoltan/csoamoba)
that presents a DOS emulator with Csőamőba version 3.4.

## Known bugs

* UTF-8 support is missing from XForms 1.2, so the code is very hacky to work this around.
* Background music and sounds are disabled.
* Computer's moves are very poor.
