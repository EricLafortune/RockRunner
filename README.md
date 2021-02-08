# Rock Runner

Rock runner is an action/exploration/puzzle game for the TI-99/4A home
computer, inspired by the game Boulder Dash on other platforms.
Collect diamonds in 2D worlds with stone, rocks, bombs, butterflies,
monsters, and lava.

## Features

* 15 challenging levels.
* Fast 4-directional scrolling.
* Introducing the colorful half-bitmap display mode.
* Sound and speech (with a speech synthesizer attached).
* Entirely written in TMS-9900 assembly code.
* The source code!

## Screenshots

![Title screen](screenshots/rock01.png)
![Navigating between rocks and bricks](screenshots/rock02.png)
![Avoiding aggressive butterflies](screenshots/rock03.png)
![Luring butterflies to lava](screenshots/rock04.png)
![Staying ahead of the butterflies and monsters](screenshots/rock05.png)
![Collecting diamonds guarded by butterflies](screenshots/rock06.png)
![Collecting diamonds](screenshots/rock07.png)
![Navigating narrow caves](screenshots/rock08.png)
![Attacking with bombs](screenshots/rock09.png)
![Escaping monsters and caves](screenshots/rock10.png)

## Requirements

* TI-99/4A home computer.
* 32K memory expansion.
* Editor/Assembler module (for the disk version).

or:

* An emulator for the TI-99/4A, such as Mame.

## Building

You need to have the [xdt99](https://github.com/endlos99/xdt99)
cross-development tools installed, for the `xas99` assembler.

On Linux, you can run the build script:

    ./build.sh

Alternatively, you can run its commands manually.

You'll then have the cartridge image `out/RockRunner.rpk`.

## Running

The easiest way is to use the Mame emulator.

On Linux, you can run the script to launch Mame with the proper options:

    ./run.sh

Alternatively, you can run the Mame command manually.

Once Mame is running and showing the TI-99/4A launch screen:

1. Press any key.
2. Press `2` for "Rock Runner"

The game then starts. You can select a screen with the joystick and `fire`
to start playing.

You can exit Mame by pressing `Insert` and then `Esc`.

## History

I wrote Rock Runner around 1986, using a basic TI-99/4A, a Mini Memory module
with 4K of battery-backed memory, a regular 32K memory expansion, and a
cassette tape recorder for external storage. The line-by-line assembler could
convert individual assembly instructions and write them straight to memory.
The memory editor then still allowed to edit a program as hexadecimal values,
manually changing opcodes and moving instructions and data around. Those were
the days!

Decades later, [Ralph
Benzinger](https://atariage.com/forums/profile/35214-ralphb/) 's excellent
[xdt99](https://github.com/endlos99/xdt99) cross-development tools allowed me
to disassemble the code. For the first time, I could see the source code of
my own program in full -- and so can you now. With all-new documentation,
the code is holding up pretty nicely. It can be a fun example of hand-written
assembly code for the TI-99/4A.

## Versions

You can check out the following git tags:

* `master` Version that creates an image of a Rock Runner cartridge.
* `v1.0` Version that recreates an image of the original Rock Runner floppy
  disk.

## License

Rock Runner is now released under the GNU General Public License, version 2.

Enjoy!

Eric Lafortune
