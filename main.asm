* Rock Runner - action/exploration/puzzle game for the TI-99/4A home computer.
*
* Copyright (c) 1986-2021 Eric Lafortune
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the Free
* Software Foundation; either version 2 of the License, or (at your option)
* any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

******************************************************************************
* This main file includes all other files for code, worlds, and data.
* Its start is the entry point for running the game.
******************************************************************************

    aorg >f000 ; Reconstruct the original binary.
    save >f000,
    copy "code/main.asm"

    aorg >a000
    copy "worlds/all.asm"

    aorg >3000
    save >3000, >3523
    copy "data/graphics.asm"
    copy "data/speech.asm"
    copy "data/sound.asm"
