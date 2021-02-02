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
* Header string for the game screen.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Move to data/text.asm.

header_string
    byte font2 + 'B'
    byte font2 + 'O'
    byte font2 + 'M'
    byte font2 + 'B'
    byte font2 + 'S'
    byte 0
    byte font2 + 'D'
    byte font2 + 'I'
    byte font2 + 'A'
    byte font2 + 'M'
    byte font2 + 'O'
    byte font2 + 'N'
    byte font2 + 'D'
    byte font2 + 'S'
    byte 0
    byte font2 + 'T'
    byte font2 + 'I'
    byte font2 + 'M'
    byte font2 + 'E'
    byte 0
    byte font2 + 'S'
    byte font2 + 'C'
    byte font2 + 'O'
    byte font2 + 'R'
    byte font2 + 'E'
    even
