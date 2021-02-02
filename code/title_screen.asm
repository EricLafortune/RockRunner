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
* The title screen.
******************************************************************************

* Block: draw the title screen and handle the input
*        (joystick up/down/fire, quit).
* IN @high_score: the global high score.
* OUT        r9:  the selected world definition address.
* OUT player r10: the selected joystick number (CRU bits).

* Draw the title and the text lines.
    blwp @draw_title           ; Draw the game title.
    data >0807

    li   r0, >0942             ; Initialize the other lines.
    li   r1, title_screen_strings
    li   r3, title_screen_text_definitions

title_lines_loop
    movb *r3+, r2
    srl  r2, 8
    blwp @vmbw
    a    r2, r1                ; Increment the CPU source address.
    movb *r3+, r2
    jeq  title_lines_loop_exit
    srl  r2, 8
    a    r2, r0                ; Increment the VDP destination address.
    jmp  title_lines_loop

title_lines_loop_exit
    mov  @high_score, r0       ; Display the high score.
    blwp @draw_decimal
    data >0a76
    li   r8, >0607             ; Initialize the joystick numbers (CRU bits).
    clr  r9                    ; Reset the selected world.

* Check for input.
title_screen_loop
    li   r12, >0024            ; Is the joystick up or down?
    ldcr r8, 3
    li   r12, >000c
    stcr r0, 2
    jop  title_change_world
    jmp  title_check_quit

title_change_world
    li   r1, >0180
    sb   r0, r1
    sla  r1, 3
    a    r9, r1
    mov  @world_definitions(r1), r0
    ci   r0, magic
    jne  title_check_quit
    mov  r1, r9                ; Remember the world.
    li   r0, >0ab3             ; Write the world number.
    srl  r1, 2
    ai   r1, >a100
    blwp @vsbw
    blwp @play_sounds
    data >0012

title_check_quit
    li   r12, >0024            ; Is quit depressed?
    ldcr r12, 3
    clr  r12
    tb   3
    jeq  title_check_fire
    blwp *r12                  ; Quit.

title_check_fire
    swpb r8                    ; Swap the joystick number.
    li   r12, >0024            ; Is the fire button depressed?
    ldcr r8, 3
    clr  r12
    tb   3
    jeq  title_screen_loop

    mov  r8, @player_workspace+calling_r10 ; Save the joystick number.
