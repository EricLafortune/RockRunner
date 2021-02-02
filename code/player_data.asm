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
* Player input data and object interaction data.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Merge with player.asm.

; The 4 joystick CRU bits (inverted):
;     >1 = left
;     >2 = right
;     >4 = down
;     >8 = up
joystick_cru_to_direction
;      byte >00 ; Impossible.
;      byte >00
;      byte >00
;      byte >00
;      byte >00
    byte >14 ; Up + right = right.
    byte >1e ; Up + left  = left.
    byte >00 ; Up.
    byte >00
    byte >14 ; Down + right = right.
    byte >1e ; Down + left  = left.
    byte >0a ; Down.
    byte >00
    byte >14 ; Right.
    byte >1e ; Left.
    byte >ff ; None.

    byte >00
    data >0000
    data >0000

* Offests in the records below.
world_offset    equ 0
y_delta         equ 2
x_delta         equ 4
leaving_object  equ 6
entering_object equ 7
arrived_object  equ 8

joystick_direction_to
    data -world_width ; Up.
    data -1
    data 0
    byte >89
    byte >87
    byte >80
    byte >00

    data world_width  ; Down.
    data 1
    data 0
    byte >87
    byte >89
    byte >80
    byte >00

    data 1            ; Right.
    data 0
    data 1
    byte >95
    byte >9b
    byte >90
    byte >00

    data -1           ; Left.
    data 0
    data -1
    byte >ab
    byte >a5
    byte >a0
    byte >00

* Switch tables.
switch_move_to_object
    data case_move_to_open_space  ; Empty.
    data case_move_to_bomb        ; Bomb.
    data case_move_to_bomb        ; Lit bomb0.
    data case_move_to_bomb        ; Lit bomb1.
    data case_move_to_bomb        ; Lit bomb2.
    data case_move_to_diamond     ; Diamond.
    data case_move_to_open_space  ; Soft.
    data case_dont_move           ; Lava.
    data case_dont_move           ; Brick.
    data case_push_rock           ; Rock.
    data case_dont_move           ; Concrete.
    data case_dont_move           ; Solid.
    data case_dont_move           ; Dust.
    data case_explode             ; Monster.
    data case_explode             ; Plain butterfly.
    data case_explode             ; Diamond butterfly.
