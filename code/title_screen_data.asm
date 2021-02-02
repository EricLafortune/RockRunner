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
* Alpha lock screen and title screen text definitions.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Move to data/text.asm.

* Records with text for the title screen:
*     byte = string length
*     byte = destination increment.
title_screen_text_definitions
    data >1c64 ; Programmed by Eric Lafortune
    data >0f20 ; Joystick 1 or 2
    data >1320 ; Fire to drop a bomb
    data >0e20 ; Enter to pause
    data >1520 ; Space to end a screen
    data >1343 ; Redo, back and quit
    data >0843 ; Hi score
    data >083f ; Screen A
    data >0a00 ; Press fire

* Font character offsets.
font1 equ >60 ; Cyan font.
font2 equ >A0 ; White font.

* Releaae alpha lock text.
alpha_lock_string
    byte font1 + 'R'
    byte font1 + 'E'
    byte font1 + 'L'
    byte font1 + 'E'
    byte font1 + 'A'
    byte font1 + 'S'
    byte font1 + 'E'
    byte 0
    byte font1 + 'A'
    byte font1 + 'L'
    byte font1 + 'P'
    byte font1 + 'H'
    byte font1 + 'A'
    byte 0
    byte font1 + 'L'
    byte font1 + 'O'
    byte font1 + 'C'
    byte font1 + 'K'

* Title screen strings.
title_screen_strings
    byte font1 + 'P'
    byte font1 + 'R'
    byte font1 + 'O'
    byte font1 + 'G'
    byte font1 + 'R'
    byte font1 + 'A'
    byte font1 + 'M'
    byte font1 + 'M'
    byte font1 + 'E'
    byte font1 + 'D'
    byte 0
    byte font1 + 'B'
    byte font1 + 'Y'
    byte 0
    byte font1 + 'E'
    byte font1 + 'R'
    byte font1 + 'I'
    byte font1 + 'C'
    byte 0
    byte font1 + 'L'
    byte font1 + 'A'
    byte font1 + 'F'
    byte font1 + 'O'
    byte font1 + 'R'
    byte font1 + 'T'
    byte font1 + 'U'
    byte font1 + 'N'
    byte font1 + 'E'

    byte font2 + 'J'
    byte font2 + 'O'
    byte font2 + 'Y'
    byte font2 + 'S'
    byte font2 + 'T'
    byte font2 + 'I'
    byte font2 + 'C'
    byte font2 + 'K'
    byte 0
    byte font2 + '1'
    byte 0
    byte font2 + 'O'
    byte font2 + 'R'
    byte 0
    byte font2 + '2'

    byte font2 + 'F'
    byte font2 + 'I'
    byte font2 + 'R'
    byte font2 + 'E'
    byte 0
    byte font2 + 'T'
    byte font2 + 'O'
    byte 0
    byte font2 + 'D'
    byte font2 + 'R'
    byte font2 + 'O'
    byte font2 + 'P'
    byte 0
    byte font2 + 'A'
    byte 0
    byte font2 + 'B'
    byte font2 + 'O'
    byte font2 + 'M'
    byte font2 + 'B'

    byte font2 + 'E'
    byte font2 + 'N'
    byte font2 + 'T'
    byte font2 + 'E'
    byte font2 + 'R'
    byte 0
    byte font2 + 'T'
    byte font2 + 'O'
    byte 0
    byte font2 + 'P'
    byte font2 + 'A'
    byte font2 + 'U'
    byte font2 + 'S'
    byte font2 + 'E'

    byte font2 + 'S'
    byte font2 + 'P'
    byte font2 + 'A'
    byte font2 + 'C'
    byte font2 + 'E'
    byte 0
    byte font2 + 'T'
    byte font2 + 'O'
    byte 0
    byte font2 + 'E'
    byte font2 + 'N'
    byte font2 + 'D'
    byte 0
    byte font2 + 'A'
    byte 0
    byte font2 + 'S'
    byte font2 + 'C'
    byte font2 + 'R'
    byte font2 + 'E'
    byte font2 + 'E'
    byte font2 + 'N'

    byte font2 + 'R'
    byte font2 + 'E'
    byte font2 + 'D'
    byte font2 + 'O'
    byte font2 + ','
    byte 0
    byte font2 + 'B'
    byte font2 + 'A'
    byte font2 + 'C'
    byte font2 + 'K'
    byte 0
    byte font2 + 'A'
    byte font2 + 'N'
    byte font2 + 'D'
    byte 0
    byte font2 + 'Q'
    byte font2 + 'U'
    byte font2 + 'I'
    byte font2 + 'T'

    byte font1 + 'H'
    byte font1 + 'I'
    byte 0
    byte font1 + 'S'
    byte font1 + 'C'
    byte font1 + 'O'
    byte font1 + 'R'
    byte font1 + 'E'

    byte font1 + 'S'
    byte font1 + 'C'
    byte font1 + 'R'
    byte font1 + 'E'
    byte font1 + 'E'
    byte font1 + 'N'
    byte font1 + ' '
    byte font1 + 'A'

    byte font1 + 'P'
    byte font1 + 'R'
    byte font1 + 'E'
    byte font1 + 'S'
    byte font1 + 'S'
    byte 0
    byte font1 + 'F'
    byte font1 + 'I'
    byte font1 + 'R'
    byte font1 + 'E'
