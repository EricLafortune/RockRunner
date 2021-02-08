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
* The physics engine for objects in the world: falling rocks and other
* objects, lit and exploding bombs, expanding lava.
******************************************************************************

* Switch table for the objects in the world.
switch_world_object
    data world_loop            ; Empty.
    data case_bomb             ; Bomb.
    data case_lit_bomb0        ; Lit bomb0.
    data case_lit_bomb1        ; Lit bomb1.
    data case_lit_bomb2        ; Lit bomb2.
    data case_diamond          ; Diamond.
    data world_loop            ; Soft.
    data case_lava             ; Lava.
    data world_loop            ; Brick.
    data case_rock             ; Rock.
    data world_loop            ; Concrete.
    data case_solid            ; Solid.
    data case_clear            ; Dust.
    data world_loop            ; Monster.
    data world_loop            ; Plain butterfly.
    data world_loop            ; Diamond butterfly.
    data world_loop            ; Player front.
    data world_loop            ; Player front walking.
    data world_loop            ; Player right.
    data world_loop            ; Player right walking.
    data world_loop            ; Player left.
    data world_loop            ; Player left walking.
    data case_blink            ; Player front blinking.

direction_offsets
    data 1                     ; Right.
    data -world_width          ; Up.
    data -1                    ; Left.
    data world_width           ; Down.
    data 0                     ; None.

* Function: perform the actions of all objects in the world.
* OUT r8: the current pointer in the falling object list.
apply_physics
    data physics_workspace
    data !

!   li   r8, falling_object_list ; Start collecting falling objects.

    li   r1, world + world_width ; Loop over all world cells (starting with the second row).
    li   r11, world_loop       ; We can return to the world loop from each case.

world_loop
    movb *r1+, r2              ; Switch on the object in the cell.
    srl  r2, 10
    mov  @switch_world_object(r2), r0
    b    *r0

* Switch cases.
case_solid
    ci   r1, world + world_size - world_width ; Loop until we've checked all cells (skipping the last row).
    jle   world_loop

    ; Let all falling objects fall halfway.
    li   r0, falling_object_list ; Loop over all falling objects.
falling_object_loop
    c    r0, r8
    jhe  falling_object_loop_exit
    mov  *r0+, r1              ; Get the falling object's address (+1 actually).
    mov  *r0+, r2              ; Get the falling object.

    ai   r2, >ff00             ; Put the leaving object.
    movb r2, @-1(r1)

    ai   r2, >0200             ; Put the entering object.
    movb r2, @world_width-1(r1)

    jmp  falling_object_loop

falling_object_loop_exit
    rtwp

case_bomb
    movb @world_width-1(r1), r0 ; Is the cell below the bomb empty?
    jne  !
    mov  r1, *r8+              ; Remember the falling bomb's address.
    li   r2, bomb
    mov  r2, *r8+              ; Remember the bomb itself.
!   rt

case_lit_bomb0
    li   r2, lit_bomb1         ; Further age the lit bomb 0.
    movb r2, @-1(r1)
    movb @world_width-1(r1), r0 ; Is the cell below the bomb empty?
    jne  !
    mov  r1, *r8+              ; Remember the falling bomb's address.
    mov  r2, *r8+              ; Remember the bomb itself.
!   rt

case_lit_bomb1
    li   r2, lit_bomb2         ; Further age the lit bomb 1.
    movb r2, @-1(r1)
    movb @world_width-1(r1), r0 ; Is the cell below the bomb empty?
    jne  !
    mov  r1, *r8+              ; Remember the falling bomb's address.
    mov  r2, *r8+              ; Remember the bomb itself.
!   rt

case_lit_bomb2
    mov  r1, r2                ; Let the lit bomb 2 explode.
    dec  r2
    blwp @explode_to_dust
    rt

case_diamond
    movb @world_width-1(r1), r0 ; Is the cell below the diamond empty?
    jne  !
    mov  r1, *r8+              ; Remember the falling diamond's address.
    li   r2, diamond
    mov  r2, *r8+              ; Remember the diamond itself.
!   rt

case_rock
    movb @world_width-1(r1), r0 ; Is the cell below the rock empty?
    jne  !
    mov  r1, *r8+              ; Remember the falling rock's address.
    li   r2, rock
    mov  r2, *r8+              ; Remember the rock itself.
!   rt

case_lava
    a    r1, r9                ; Pick a random direction.
    mov  r9, r2
    andi r2, >01ff
    ci   r2, >0008
    jhe  dont_expand_lava
    mov  @direction_offsets(r2), r2
    a    r1, r2
    dec  r2
    li   r3, concrete
    cb   *r2, r3               ; Is the cell in that direction soft?
    jhe  dont_expand_lava
    li   r3, lava              ; Put lava in it.
    movb r3, *r2
dont_expand_lava
    blwp @play_lava_sound
    rt

case_clear
    clr  r2                    ; Clear the object in the world.
    movb r2, @-1(r1)
    rt

case_blink
    li   r2, player_front      ; Return to the regular player object.
    movb r2, @-1(r1)
    rt

* Function: let all falling objects land.
* IN r8: the current pointer in the falling object list.
land_falling_objects
    data physics_workspace
    data !

!   li   r0, falling_object_list ; Loop over all falling objects.
    clr  r1                    ; The clear trailing object.
landing_object_loop
    c    r0, r8
    jhe  landing_object_loop_exit
    mov  *r0+, r2              ; Get the falling object's address (+1 actually).
    mov  *r0+, r3              ; Get the falling object.

    movb r1, @-1(r2)           ; Clear the trailing cell.
    movb r3, @world_width-1(r2) ; Put the landing object.

    ai   r2, 2*world_width-1   ; Get the object on which the object has landed.
    movb *r2, r3
    jeq  landing_object_loop   ; Is it empty?
    blwp @queue_sound
    data land_object_sound
    ci   r3, monster           ; Is it a creature?
    jl   landing_object_loop
    ci   r3, diamond_butterfly - >0300 ; Is it a diamond creature?
    jhe  land_explode_to_diamond
land_explode_to_dust
    blwp @explode_to_dust
    jmp  landing_object_loop
land_explode_to_diamond
    blwp @explode_to_diamond
    jmp  landing_object_loop

landing_object_loop_exit
    rtwp
