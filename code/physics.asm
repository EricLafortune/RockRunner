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

* Function: perform the actions of all objects in the world.
apply_physics_code
    li   r1, world + world_width
    li   r4, falling_bomb_addresses
    li   r5, falling_lit_bomb1_addresses
    li   r6, falling_lit_bomb2_addresses
    li   r7, falling_diamond_addresses
    li   r8, falling_rock_addresses
    li   r10, world_loop

world_loop
    movb *r1+, r2              ; Switch.
    srl  r2, 10
    mov  @switch_world_object(r2), r0
    b    *r0

world_loop_test
    ci   r1, world + world_size - world_width
    jl   world_loop

    clr  *r4                   ; Set the terminating zeros for the lists of falling objects.
    clr  *r5
    clr  *r6
    clr  *r7
    clr  *r8

    bl   @let_objects_fall
    data falling_bomb_addresses
    data >0709
    bl   @let_objects_fall
    data falling_lit_bomb1_addresses
    data >1719
    bl   @let_objects_fall
    data falling_lit_bomb2_addresses
    data >1f21
    bl   @let_objects_fall
    data falling_diamond_addresses
    data >2729
    bl   @let_objects_fall
    data falling_rock_addresses
    data >4749
    rtwp

* Subroutine: let the specified list of objects fall halfway.
* IN data (word): the address of te object adress (+1) list.
* IN data (byte): the leaving falling object to be written.
* IN data (byte): the entering falling object to be written.
let_objects_fall
    mov  *r11+, r0
    movb *r11+, r1
    movb *r11+, r2

fall_object_loop
    mov  *r0+, r3
    jeq  fall_object_loop_exit
    movb r1, @-1(r3)
    movb r2, @world_width-1(r3)
    jmp  fall_object_loop

fall_object_loop_exit
    rt

* Switch cases.
case_bomb
    bl   @skip_next_if_empty_below ; Is the cell below the bomb empty?
    mov  r1, *r4+              ; Put the address in the list of falling bombs.
    b    *r10

case_lit_bomb0
    li   r2, lit_bomb1         ; Further age the lit bomb 0.
    movb r2, @-1(r1)
    bl   @skip_next_if_empty_below ; Is the cell below the lit bomb empty?
    mov  r1, *r5+                  ; Put the address in the list of falling lit bombs 1.
    b    *r10

case_lit_bomb1
    li   r2, lit_bomb2         ; Further age the lit bomb 1.
    movb r2, @-1(r1)
    bl   @skip_next_if_empty_below ; Is the cell below the lit bomb empty?
    mov  r1, *r6+                  ; Put the address in the list of falling lit bombs 2.
    b    *r10

case_lit_bomb2
    mov  r1, r2                ; Let the lit bomb 2 explode.
    dec  r2
    blwp @explode_to_dust
    b    *r10

case_diamond
    bl   @skip_next_if_empty_below ; Is the cell below the diamond empty?
    mov  r1, *r7+                  ; Put the address in the list of falling diamonds.
    b    *r10

case_rock
    bl   @skip_next_if_empty_below ; Is the cell below the rock empty?
    mov  r1, *r8+                  ; Put the address in the list of falling rocks.
    b    *r10

* Subroutine: skip the next instruction if the object below the specified object is empty.
* IN  r1: the address of the object + 1.
* OUT r2: the object below.
skip_next_if_empty_below
    movb @>003f(r1), r2
    jeq  skip_next_if_empty_below_exit
    inct r11

skip_next_if_empty_below_exit
    rt

* Swith cases continued.
case_lava
    a    r1, r9                ; Pick a random direction.
    mov  r9, r2
    andi r2, >01ff
    ci   r2, >0008
    jhe  dont_expand_lava
    mov  @direction_offsets(r2), r2
    a    r1, r2
    dec  r2
    li   r3, concrete          ; Is the cell in that direction soft?
    cb   *r2, r3
    jhe  dont_expand_lava
    li   r3, lava              ; Put lava in it.
    movb r3, *r2
dont_expand_lava
    blwp @play_lava_sound
    b    *r10

case_clear
    clr  r2                    ; Clear the object in the world.
    movb r2, @-1(r1)
    b    *r10

case_blink
    li   r2, player_front      ; Return to the regular player object.
    movb r2, @-1(r1)
    b    *r10

* Function: land all falling objects.
land_falling_objects_code
    clr  r0                    ; The clear trail.
    bl   @land_objects         ; Land all falling bombs.
    data falling_bomb_addresses
    data bomb
    bl   @land_objects         ; Land all falling lit bombs 1.
    data falling_lit_bomb1_addresses
    data lit_bomb1
    bl   @land_objects         ; Land all falling lit bombs 2.
    data falling_lit_bomb2_addresses
    data lit_bomb2
    bl   @land_objects         ; Land all falling diamonds.
    data falling_diamond_addresses
    data diamond
    bl   @land_objects         ; Land all falling rocks.
    data falling_rock_addresses
    data rock
    rtwp

* Subroutine: land the specified falling objects.
* IN     data: the 0-terminated list of addresses of failling objects.
* IN     data: the eventual landed object.
* STATIC r0:
land_objects
    mov  *r11+, r1             ; Get the list of addresses.
    mov  *r11+, r3             ; Get the landed object.

land_object_loop
    mov  *r1+, r2              ; Get the falling object address.
    jeq  land_object_loop_exit ; Didn't we get to the end of the list?
    movb r0, @-1(r2)           ; Clear the leaving falling object.
    movb r3, @world_width-1(r2) ; Set the landed falling object.
    ai   r2, 2*world_width-1   ; Get the object on which the object has landed.
    movb *r2, r4
    jeq  land_dont_explode     ; Is it empty?
    blwp @queue_sound
    data >0097
    ci   r4, monster           ; Is it a creature?
    jl   land_dont_explode
    ci   r4, >7500             ; Is it a diamond creature?
    jhe  land_explode_to_diamond
land_explode_to_dust
    blwp @explode_to_dust
    jmp  land_dont_explode
land_explode_to_diamond
    blwp @explode_to_diamond
land_dont_explode
    jmp  land_object_loop

land_object_loop_exit
    rt
