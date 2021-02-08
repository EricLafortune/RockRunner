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
* Functions related to collectables: diamonds and bombs.
******************************************************************************

* Function: account for collecting a diamond.
* STATIC r4:  the current number of bombs.
* STATIC r5:  the current number of diamonds.
* STATIC r6:  the required number of diamonds.
* STATIC r7:  the remaining time.
* STATIC r8:  the current score.
* STATIC r9:  the current world number.
* STATIC r10: the number of lives.
collect_diamond
    data collectables_workspace
    data !

!   inc  r5                    ; Increment the count.
    mov  r5, r0                ; Display the number.
    blwp @draw_decimal
    data >082a

    ai   r8, >000a             ; Increment the score.
    mov  r8, r0                ; Display the score.
    blwp @draw_decimal
    data >0839

    blwp @queue_sound
    data collect_diamond_sound
    c    r5, r6                ; Check if we've reached the required number.
    jne  not_required_number_yet

    .vdpwr 7, >0f              ; Flash the screen to white.

    blwp @queue_random_speech
    data collected_diamonds_phrases
    blwp @queue_sound
    data collected_diamonds_sound

not_required_number_yet
    rtwp

* Function: account for collecting a bomb.
* STATIC r4:  the current number of bombs.
* STATIC r5:  the current number of diamonds.
* STATIC r6:  the required number of diamonds.
* STATIC r7:  the remaining time.
* STATIC r8:  the current score.
* STATIC r9:  the current world number.
* STATIC r10: the number of lives.
collect_bomb
    data collectables_workspace
    data !

!   inc  r4                    ; Increment the count.
    mov  r4, r0                ; Display the number.
    blwp @draw_decimal
    data >0825
    blwp @queue_sound
    data collect_bomb_sound
    rtwp

* Function: account for dropping a bomb.
*           Skip the next two instruction words if we can't drop a bomb.
* STATIC r4:  the current number of bombs.
* STATIC r5:  the current number of diamonds.
* STATIC r6:  the required number of diamonds.
* STATIC r7:  the remaining time.
* STATIC r8:  the current score.
* STATIC r9:  the current world number.
* STATIC r10: the number of lives.
drop_bomb
    data collectables_workspace
    data !

!   mov  r4, r4                ; Do we have any bombs?
    jeq  no_bombs
    dec  r4                    ; Decrement the count.
    mov  r4, r0                ; Display the number.
    blwp @draw_decimal
    data >0825
    blwp @queue_sound
    data drop_bomb_sound
    rtwp

no_bombs
    c    *r14+, *r14+          ; Skip the next two words.
    rtwp
