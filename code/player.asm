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
* Player-related functions: reading the joytsick, motion in two phases
* (one character at a time), dropping bombs.
******************************************************************************

* Function:  move the player to his starting position, while drawing the screen.
* IN         r0: the player address in the world.
* STATIC OUT r8: the player y position.
* STATIC OUT r9: the player x position.
initial_scroll_code
    blwp @initialize_screen_position

    mov  *r13, r6              ; Get the player address.
    ai   r6, >e000             ; Compute the player offset.
    mov  r6, r7
    srl  r6, 6                 ; Compute the player destination y position.
    andi r7, >003f             ; Compute the player destination x position.
    li   r8, world_height / 2  ; Set the initial player y position.
    li   r9, world_width / 2   ; Set the initial player x position.

initial_horizontal_move_loop
    c    r9, r7
    jeq  initial_vertical_move_loop ; Has the player reached the horizontal destination?
    jh   initial_move_left          ;Should he move right or left?
initial_move_right
    inct r9
initial_move_left
    dec  r9

    blwp @play_sounds
    data >0000

    blwp @draw_world           ; Draw the world in phase 1.

    blwp @play_sounds
    data >0009

    blwp @draw_world           ; Draw the world in phase 2.
    jmp  initial_horizontal_move_loop

initial_vertical_move_loop
    c    r8, r6                   ; Has the player reached the vertical destination?
    jeq  initial_scroll_loop_exit ; Should he move down or left?
    jh   initial_move_up
initial_move_down
    inct r8
initial_move_up
    dec  r8
    blwp @play_sounds
    data >0000

    blwp @draw_world           ; Draw the world in phase 1.

    blwp @play_sounds
    data >0009

    blwp @draw_world           ; Draw the world in phase 2.
    jmp  initial_vertical_move_loop

initial_scroll_loop_exit
    rtwp

* Function: initialize the screen position.
* STATIC r0: screen y position.
* STATIC r1: screen x position.
initialize_screen_position_code
    li   r0, >000a
    li   r1, >0018
    rtwp

* Function: move the player in the world (phase 1: walking half-way
*           across two cells in the world, by one character on the screen).
* STATIC OUT r1:  the old player address.
* STATIC OUT r2:  the new player address.
* STATIC OUT r3:  the player direction.
* STATIC     r7:  a countdown since the last move.
* STATIC     r8:  the player y position.
* STATIC     r9:  the player x position.
* STATIC     r10: the joystick number (CRU bits).
move_player_phase1_code
    mov  r8, r1                ; Compute the player object address.
    sla  r1, 6
    a    r9, r1
    ai   r1, world
    mov  r1, r2                ; The new addrss is the same for now.

    movb *r1, r0               ; Is the player still there?
    ci   r0, player_front
    jhe  get_joystick

    mov  r7, r7                ; Did we die just now?
    jlt  dead
    clr  r7
    blwp @queue_random_speech  ; Queue a random speech phrase.
    data >0036
dead
    rtwp

get_joystick
    li   r12, >0024            ; Get the joystick CRU bits.
    ldcr r10, 3
    li   r12, >0008
    stcr r3, 4
    srl  r3, 8                 ; Convert it to a player direction.
    movb @joystick_cru_to_direction-5(r3), r3
    jlt  finalize_player_motion ; Is there any motion?

    srl  r3, 8                 ; Compute the destination player address.
    a    @joystick_direction_to+world_offset(r3), r2

    movb *r2, r4               ; Branch, based on the object at that address.
    srl  r4, 10
    mov  @switch_move_to_object(r4), r5
    b    *r5

case_move_to_bomb
    blwp @collect_bomb
    jmp  case_move_to_open_space

case_move_to_diamond
    blwp @collect_diamond
    jmp  case_move_to_open_space

case_push_rock
    mov  @joystick_direction_to+x_delta(r3), r4 ; Can we push this object in this direction?
    jeq  case_dont_move
    a    r4, r2                ; Is the cell behind the object clear?
    movb *r2, r0
    jne  case_dont_move
    li   r0, rock              ; Put a rock in the destination.
    movb r0, *r2
    s    r4, r2                ; Don't change the destination.
    blwp @queue_sound
    data >0090
    jmp  case_move_to_open_space

case_explode
    blwp @explode_to_diamond
    jmp  case_dont_move

case_move_to_open_space
    a    @joystick_direction_to+y_delta(r3), r8 ; Update the player position.
    a    @joystick_direction_to+x_delta(r3), r9
    movb @joystick_direction_to+leaving_object(r3), *r1  ; Set the player object half-way leaving a cell.
    movb @joystick_direction_to+entering_object(r3), *r2 ; Set the player object half-way entering a cell.
    rtwp

case_dont_move
    movb @joystick_direction_to+arrived_object(r3), *r1

finalize_player_motion
    mov  r1, r2
    rtwp

* Function: move the player in the world (phase 2: walking all the way
*           to the new cell, by one character on the screen).
*           Leave a bomb if the fire button is pressed.
* STATIC r1:  the old player address.
* STATIC r2:  the new player address.
* STATIC r3:  the player direction.
* STATIC r7:  a countdown since the last move.
* STATIC r8:  the player y position.
* STATIC r9:  the player x position.
move_player_phase2_code
    c    r1, r2                ; Are we moving?
    jeq  player_standing

    clr  r0                    ; Is the fire button depressed?
    li   r12, >0024
    ldcr r10, 3
    clr  r12
    tb   3
    jeq  dont_drop_bomb
    blwp @drop_bomb            ; Then drop a bomb behind the player.
    li   r0, lit_bomb0

dont_drop_bomb
    movb r0, *r1               ; Set the player object completely leaving a cell.
    movb @joystick_direction_to+arrived_object(r3), *r2 ; Set the player object completely entering a cell.

    li   r7, >0017             ; Start counting down.
    rtwp

player_standing
    dec  r7                    ; Has it been a while since the player has moved?
    jne  player_not_standing_long
    li   r0, player_front_blinking ; Animate the player object.
    movb r0, *r2
    li   r7, >003d             ; Queue a random speech phrase.
    blwp @queue_random_speech
    data >000a

player_not_standing_long
    rtwp
