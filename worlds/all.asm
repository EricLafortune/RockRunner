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
* This file includes all files with individual world definitions.
******************************************************************************

    ; We'll package the worlds in cartridge GROM (2 x 8K @ >6000).
    aorg >6000
    save >6000, >a000

; A world definition starts with a header (that overlaps with the first bytes
; of the border).
;     word = magic.
;     word = bombs.
;     word = diamonds.
;     word = time.
magic equ >454c

; The 64x32 cells of a world are defined by nibbles:
;     0 = empty.
;     1 = bomb.
;     2 = lit bomb0.
;     3 = lit bomb1.
;     4 = lit bomb2.
;     5 = diamond.
;     6 = soft.
;     7 = lava.
;     8 = brick.
;     9 = rock.
;     a = concrete.
;     b = solid (including world edge).
;     c = dust (initial player).
;     d = monster.
;     e = plain butterfly.
;     f = diamond butterfly.

    copy "a.asm"
    copy "b.asm"
    copy "c.asm"
    copy "d.asm"
    copy "e.asm"
    copy "f.asm"
    copy "g.asm"
    copy "h.asm"
    copy "i.asm"
    copy "j.asm"
    copy "k.asm"
    copy "l.asm"
    copy "m.asm"
    copy "n.asm"
    copy "o.asm"
