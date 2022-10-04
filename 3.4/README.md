# Version 3.4 (DOS)

This is the original version of Csőamőba, developed for MS-DOS, back in 1994.
You need to run it in a DOS emulator.

## Running Csőamőba 3.4 on Linux in a DOSBox

You need to install [DOSBox](https://www.dosbox.com/) first. It is simple if you use the package
manager of your system (e.g., on Ubuntu you need the package `dosbox`). The binary version can be
found in this folder, but (a slightly modified version of) the source code is also included.

So eventually you may want to recompile the program.
This folder includes [a freely available version](https://sourceforge.net/projects/turbopascal-wdb/)
of [Turbo Pascal](https://en.wikipedia.org/wiki/Turbo_Pascal) 7.0.

### Running the game

Issue `run.sh` or `make`.

### Recompiling the game

After editing the file [CSAV34.PAS](CSAV34.PAS) (warning: it is a [CP 852](https://en.wikipedia.org/wiki/Code_page_852) encoded file),
issue `compile.sh`. Then run the game. Lazy users may simply type `make` to compile and run the program consecutively.

#### Changes on the original source code

* Some file names have been simplified to avoid non-ASCII characters.
* Turbo Pascal 7.0 seems to have a bug in the `ClearDevice` command. This is fixed by working around this command.

#### Version issues of Turbo Pascal

* Turbo Pascal 7.0 does not seem to be officially released freely by Borland. Turbo Pascal 5.5 is completely free to download.
  Unfortunately, Turbo Pascal 5.5 contains an incomplete set of accented characters and it is not fully ready to compile
  Csőamőba 3.4. (It compiles but some messages are displayed incorrectly.) Hence here Turbo Pascal 7.0 is included.
