Water and Stone RPG
===================

A game engine in BASIC resurrected from my childhood.

Play for fun or read the source and cry.


Features
--------

    * Prolific examples of GOTO's and global variables
    * Direct memory fiddling for graphics and input
    * Liberal use of copy/paste coding techniques
    * Completely flat directory structure.


Installation
------------

Install `Dosbox <http://www.dosbox.com>`_ on your system according to the directions on their site. On debian flavored GNU/Linux you can try::

    apt-get install dosbox

Set the clock speed by typing `cycles=30000` at the DOS prompt or configuring your dosbox conf file.

Download the following DOS utilities

    * Microsoft Basic Compiler Version 7.10
    * Microsoft Segmented-Executable Linker Version 5.10

These are BC.EXE and LINK.EXE respectively. Copy these programs into the same directory as this source code.

Run `build.bat` in a DOS prompt and press enter through all of the prompts.

Running the Game
----------------

After compiling, use a DOS prompt and run::
    start.exe

Instructions for Play
---------------------

During play

    * Arrow keys - Move Character
    * Space bar - Main menu
    * F1 - Help
    * Esc - Quit
    * F3 - Save
    * F4 - Load
    * F5 - Score
    * F6 - Magic
    * F7 - Inventory

In a menu
    * Use arrow keys to move the cursor
    * Use space bar to make a selection


Editing Game Assets
-------------------

There are three utilities for editing game assets, there names followed by uses are listed below:

    * PAINT - Editing map tiles, characters, items (anything 10 X 10)
    * BACKMAKE - Editing background files
    * MAPDRAW - Editing maps

These are all run from a DOS prompt by typing their names

Some additional notes about game asset files"

    * All tiles and maps are plain text .DAT files, while the backgrounds are binary .DIS files.
    * The tiles and character files are prefixed by TILE and CHAR
    * The map files are prefixed with Island, Town, Mtn, Forest, Home, House, Elder (possibly a few others)


Controls for these tools are the same:
    * Make sure dosbox is in fullscreen mode (Press ALT+ENTER) or has focus for the mouse pointer to work.
    * Use the left and right arrow keys to select a color. It's slow going, but there are only 256 colors to choose from.
    * F3 - Save as current filename
    * F4 - Load current filename (or reload)
    * F5 - Change current filename
    * F6 - Rotate tile (Paint only)

N.B. If F5 is used to change to a filename that doesn't yet exist, loading will crash the editor.

The details of the following assets are undocumented and unecessarily labyrinthine:
    * WILD, DOG and SPIDER DAT files are monster stat files that are edited by hand.
    * Some other DAT files such as SCALP, ROPE, and AQUA represent pictures of items or icons for spells
    * Files beginning with SAVE and followed by a number are saved game files.
    * The game uses SAVEFILE.DAT to keep track of save game files. Do not edit this.
    * There are various temporary files that are created at runtime to pass data between different programs.