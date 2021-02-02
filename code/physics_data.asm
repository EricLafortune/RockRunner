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
* Object behavioral data.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Merge with physics.asm.

* Physics branch table.
switch_world_object
    data world_loop               ; Empty.
    data case_bomb                ; Bomb.
    data case_lit_bomb0           ; Lit bomb0.
    data case_lit_bomb1           ; Lit bomb1.
    data case_lit_bomb2           ; Lit bomb2.
    data case_diamond             ; Diamond.
    data world_loop               ; Soft.
    data case_lava                ; Lava.
    data world_loop               ; Brick.
    data case_rock                ; Rock.
    data world_loop               ; Concrete.
    data world_loop_test          ; Solid.
    data case_clear               ; Dust.
    data world_loop               ; Monster.
    data world_loop               ; Plain butterfly.
    data world_loop               ; Diamond butterfly.
    data world_loop               ; Player front.
    data world_loop               ; Player front walking.
    data world_loop               ; Player right.
    data world_loop               ; Player right walking.
    data world_loop               ; Player left.
    data world_loop               ; Player left walking.
    data case_blink               ; Player front blinking.

direction_offsets
    data 1                        ; Right.
    data -world_width             ; Up.
    data -1                       ; Left.
    data world_width              ; Down.
