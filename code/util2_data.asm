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
* Title display data.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Merge with data/graphics.asm.

title_characters
    byte >00 ; "Rock", 3 lines high.
    byte >00
    byte >00
    byte >25
    byte >50
    byte >00
    byte >26
    byte >50
    byte >00
    byte >26
    byte >4f
    byte >00
    byte >25
    byte >4f

    byte >4a
    byte >48
    byte >00
    byte >25
    byte >51
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >25
    byte >00
    byte >00
    byte >25
    byte >51

    byte >4b
    byte >49
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >28
    byte >52
    byte >00
    byte >28
    byte >4f
    byte >00
    byte >25
    byte >4f

    byte >25 ; "Runner", 3 lines high.
    byte >50
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >26
    byte >50
    byte >00
    byte >26
    byte >50
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >25
    byte >50

    byte >25
    byte >51
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >25
    byte >00
    byte >00
    byte >25
    byte >51

    byte >25
    byte >4f
    byte >00
    byte >28
    byte >52
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >25
    byte >4f
    byte >00
    byte >25
    byte >4f
    even

xf17e
    byte >71 ; Unused?
    byte >d0
