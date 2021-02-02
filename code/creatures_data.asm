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
* Creature animation data.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Merge with creatures.asm.

; Offsets in the records below.
leaving  equ 0
entering equ 1

* Animated creature objects.
moving_monster_objects
    data >656b                    ; Right.
    data >6967                    ; Up.
    data >6b65                    ; Left.
    data >6769                    ; Down.

moving_plain_butterfly_objects
    data >6d73                    ; Right.
    data >716f                    ; Up.
    data >736d                    ; Left.
    data >6f71                    ; Down.

moving_diamond_butterfly_objects
    data >757b                    ; Right.
    data >7977                    ; Up.
    data >7b75                    ; Left.
    data >7779                    ; Down.

    data >0000                    ; Unused.
