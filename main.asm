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
* This main file includes all other files for code, data, and worlds.
******************************************************************************

    ; We'll pachage the code and data in cartridge ROM (1 x 8K @ >6000).
    aorg >6000
    save >6000, >8000

    ; The ROM header.
    byte >aa           ; Magic.
    byte >01           ; Version.
    byte >01           ; Number of programs.
    byte >00
    data >0000;        ; Power-up list pointer.
    data program_list  ; Program list pointer.
    data >0000         ; DSR list pointer.
    data >0000         ; Subprogram list pointer.

program_list
    data >0000         ; Next pointer.
    data main          ; Program address.
    byte 11            ; Name length.
    text 'ROCK RUNNER' ; Name.

    ; The code and data.
    copy "code/main.asm"

    copy "data/text.asm"
    copy "data/graphics.asm"
    copy "data/speech.asm"
    copy "data/sound.asm"

    ; We'll package the worlds in cartridge GROM (2 x 8K @ >6000).
    ;aorg >0000
    ;save >0000, >4000
    ;copy "worlds/all.asm"

