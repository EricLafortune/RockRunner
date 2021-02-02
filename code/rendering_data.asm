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
* Object display data.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Merge with data/graphics.asm.

* Offets in the object character records below. The 2x2 charqcters are stored
* as a sequence of bytes
*     top_left bottom_left >00 top_right bottom_right
* to allow reusing the same sequence with different offsets for scrolled
* versions of the object.
top_left     equ 0
bottom_left  equ 1
top_right    equ 3
bottom_right equ 4

* Characters that correspond to the objects.
object_characters
    data >0000 ; Empty.
    data >0000
    data >0000
    data >0000
    data >0102 ; Bomb.
    data >0003
    data >0400
    data >0000
    data >0502 ; Lit bomb0.
    data >0006
    data >0400
    data >0000
    data >3002 ; Lit bomb1.
    data >002f
    data >0400
    data >0000
    data >0502 ; Lit bomb2.
    data >0006
    data >0400
    data >0000
    data >0708 ; Diamond.
    data >0031
    data >3200
    data >0000
    data >0933 ; Soft.
    data >0009
    data >3300
    data >0000
    data >0a0a ; Lava.
    data >000a
    data >0a00
    data >0000
    data >0b0b ; Brick.
    data >000b
    data >0b00
    data >0000
    data >0c0d ; Rock.
    data >000e
    data >0f00
    data >0000
    data >1010 ; Concrete.
    data >003a
    data >3a00
    data >0000
    data >1111 ; Solid.
    data >0011
    data >1100
    data >0000
    data >1213 ; Dust.
    data >003c
    data >3d00
    data >0000
    data >1415 ; Monster.
    data >003e
    data >3f00
    data >0000
    data >1617 ; Plain butterfly.
    data >0040
    data >4100
    data >0000
    data >1819 ; Diamond butterfly.
    data >0042
    data >4300
    data >0000
    data >1a1b ; Player front.
    data >0044
    data >4500
    data >0000
    data >1a1c ; Player front walking.
    data >0044
    data >1d00
    data >0000
    data >1e1f ; Player right.
    data >0020
    data >2100
    data >0000
    data >1e22 ; Player right walking.
    data >0020
    data >2300
    data >0000
    data >4a4b ; Player left.
    data >0048
    data >4900
    data >0000
    data >4a4d ; Player left walking.
    data >0048
    data >4c00
    data >0000
    data >241b ; Player front blinking.
    data >004e
    data >4500
    data >0000
