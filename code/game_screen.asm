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
* The game engine.
******************************************************************************

* Offsets in the header of the definition of a world.
world_definition_magic_offset    equ 0
world_definition_bombs_offset    equ 2
world_definition_diamonds_offset equ 4
world_definition_time_offset     equ 6

* The magic value that identifies a world defintion.
magic equ >454c                ;

* Block: decompress the world and play the game.
*        Continue to the same world, the mext world, or the alpha lock screen
*        at the end.
* LOCAL  r4:  the initial number of bombs.
* LOCAL  r5:  the current number of diamonds.
* LOCAL  r6:  the required number of diamonds.
* LOCAL  r7:  the remaining time.
* LOCAL  r8:  the current score.
* LOCAL  r9:  the number of lives.
* SATTIC r10: the world number.
* STATIC r11: the high score.

* Start the world with a clean score and number of lives.
start_world
    clr  r8                    ; Clear the score.
    li   r9, >0005             ; Initialize the number of lives.

* Start the world with the same score and number of lives.
restart_world
    blwp @vdp_fill             ; Clear the screen.
    data >0800
    data >0000
    data >0300

* Display the header.
    li   r0, >0801             ; Display the header text.
    li   r1, header_string
    li   r2, >0019
    blwp @vmbw

    mov  r10, r0                ; Set the GROM start address for the world definition.
    sla  r0, grom_world_definition_size_shift
    ai   r0, grom_world_definitions + world_definition_bombs_offset
    .grmwa r0

    .grmrd r4                  ; Get the initial number of bombs.
    clr    r5                  ; Clear the initial number of diamonds.
    .grmrd r6                  ; Get the required number of diamonds.
    .grmrd r7                  ; Get the provided time.

    mov  r4, r0                ; Display the number of bombs.
    blwp @draw_decimal
    data >0825
    mov  r5, r0                ; Display the number of diamonds.
    blwp @draw_decimal
    data >082a
    mov  r6, r0                ; Display the required number of diamonds.
    blwp @draw_decimal
    data >082e
    mov  r7, r0                ; Display the remaining time.
    blwp @draw_decimal
    data >0833
    mov  r8, r0                ; Display the score.
    blwp @draw_decimal
    data >0839
    li   r0, >081b             ; Display the screen number.
    mov  r10, r1
    sla  r1, 8
    ai   r1, >a100
    blwp @vsbw
    li   r0, >083b             ; Draw the number of spare lives.
    li   r1, heart_character
    mov  r9, r2
draw_lives_loop
    dec  r2
    jeq  draw_lives_loop_exit
    blwp @vsbw
    inc  r0
    jmp  draw_lives_loop
draw_lives_loop_exit
    li   r0, >082b             ; Draw a slash before the required number of diamonds.
    li   r1, >cf00
    blwp @vsbw

* Initialize the world.
    li   r0, world             ; Initialize the start of the live world with
    li   r1, solid | (solid / 256) ; border objects, to avoid the header.
    li   r2, >0008
initialize_border_loop
    mov  r1, *r0+
    dec  r2
    jne  initialize_border_loop

uncompress_world_loop
    movb @grmrd, r1            ; Get the world data.
    movb r1, r2                ; Expand the first nibble to an object.
    andi r2, >f000
    srl  r2, 1
    movb r2, *r0+
    movb r1, r2                ; Expand the second nibble to an object.
    andi r2, >0f00
    sla  r2, 3
    movb r2, *r0+
    ci   r0, world+world_size  ; Loop until we've reached the end of the world.
    jne  uncompress_world_loop

    blwp  @initialize_creatures  ; Find all creatures in the world.

    li   r0, world + world_width ; Find the player in the world.
    li   r1, dust
find_player_loop
    cb   *r0+, r1
    jne  find_player_loop
    dec  r0

    blwp @initial_scroll       ; Scroll to the player

    li   r1, player_front_blinking ; Set the intiial player object.
    movb r1, *r0

    blwp @queue_random_speech
    data start_phrases

* The main game loop.
game_loop
    blwp @clear_explosions     ; Clear the lists of explosions.
    blwp @move_player_phase1
    blwp @apply_physics
    blwp @move_creatures_phase1
    blwp @update_speech_sound
    blwp @draw_world
    blwp @move_player_phase2
    blwp @land_falling_objects
    blwp @move_creatures_phase2
    blwp @apply_explosions     ; Apply the collected lists of explosioons.

    li   r0, >1000             ; Wait a moment.
game_wait_loop
    dec  r0
    jne  game_wait_loop

    blwp @update_animation_speech_sound
    blwp @draw_world

    c    r5, r6                ; Did we just reach the required number of diamonds?
    jne  game_check_redo

    .vdpwr 7, >01              ; Flash the screen back to black.

* Check the keyboard.
game_check_redo
    li   r0, >0200             ; Is redo depressed?
    li   r12, >0024
    ldcr r0, 3
    clr  r12
    tb   6
    jeq  game_check_back
    blwp @play_sounds          ; Then return to this world screen.
    data key_sound
    b    @start_world

game_check_back
    li   r0, >0100             ; Is back depressed?
    li   r12, >0024
    ldcr r0, 3
    clr  r12
    tb   6
    jeq  game_check_quit
    blwp @play_sounds          ; Then return to the title screen.
    data key_sound
    b    @alpha_lock_screen

game_check_quit
    li   r12, >0024            ; Is quit depressed?
    ldcr r12, 3
    clr  r12
    tb   3
    jeq  game_check_space
    blwp *r12                  ; Then quit.

game_check_enter
    tb   5                     ; Is enter depressed?
    jeq  game_check_space
    blwp @play_sounds          ; Then pause.
    data key_sound

game_check_enter_up_loop
    tb   5                     ; Wait until enter is released.
    jne  game_check_enter_up_loop

game_check_enter_down_loop
    tb   5                     ; Wait until enter is pressed again.
    jeq  game_check_enter_down_loop

game_check_space
    tb   4                     ; Is space depressed?
    jne  leave_world

* Check the time.
update_time
    dec  r7                    ; Decrement the remaining time.
    jlt  out_of_time           ; Have we run out of time earlier?

    mov  r7, r0                ; Display the remaining time.
    blwp @draw_decimal
    data >0833

    jne  not_out_of_time       ; Have we run out of time now?
    mov  @player_workspace+calling_r2, r0 ; Turn the player to dust.
    li   r1, dust
    movb r1, *r0

    blwp @queue_random_speech
    data out_of_time_phrases
    blwp @queue_sound
    data out_of_time_sound

not_out_of_time
    ci   r7, 100               ; Is the remaining time getting low?
    jne  continue_game_loop

    blwp @queue_random_speech  ; Then say something.
    data almost_out_of_time_phrases
    blwp @queue_sound
    data almost_out_of_time_sound

continue_game_loop
    jmp  game_loop

out_of_time
    ci   r7, >ffce             ; Are we way out of time?
    jne  continue_game_loop

leave_world
    blwp @play_sounds
    data key_sound

    c    r5, r6                ; Do we have the required number of diamonds?
    jhe  add_bombs_bonus_loop

    dec  r9                    ; Decrement the number of lives.
    jne  same_world            ; Continue if we have lives left.
    c    r8, r11               ; Did we beat the high score?
    jl   continue_alpha_lock_screen
    mov  r8, r11               ; Update the high score.
    blwp @play_sounds
    data high_score_sound

continue_alpha_lock_screen
    b    @alpha_lock_screen

* Add a bonus for the unused bombs.
add_bombs_bonus_loop
    dec  r4                    ; Decrement the number of bombs.
    jlt  add_time_bonus_loop
    mov  r4, r0                ; Display the number.
    blwp @draw_decimal
    data >0825
    ai   r8, 100               ; Increment the score.
    mov  r8, r0                ; Display the score.
    blwp @draw_decimal
    data >0839
    blwp @play_sounds
    data bomb_bonus_sound
    jmp  add_bombs_bonus_loop

* Add a bonus for the unused time.
add_time_bonus_loop
    dec  r7                    ; Decrement the time.
    jlt  next_world
    mov  r7, r0                ; Display the time.
    blwp @draw_decimal
    data >0833
    inc  r8                    ; Increment the score.
    mov  r8, r0                ; Display the score.
    blwp @draw_decimal
    data >0839
    blwp @play_sounds
    data time_bonus_sound
    jmp  add_time_bonus_loop

* Advance to the next world.
next_world
    inc  r10                    ; Increment the world number.

    mov  r10, r0                ; Compute the world definition GROM address.
    sla  r0, grom_world_definition_size_shift
    ai   r0, grom_world_definitions

    .grmwa r0                  ; Check the magic header value.
    .grmrd r0
    ci   r0, magic             ; Is it a valid world definition?
    jeq  same_world
    clr  r10                    ; Otherwise return to the first world.

* Transition to a fresh world.
same_world
    blwp @play_sounds
    data next_world_sound
    b    @restart_world
