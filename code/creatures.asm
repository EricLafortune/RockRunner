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
* Autonomous monsters and butterflies: motion in two phases (one character
* at a time) and explosions.
******************************************************************************

* Function: move the creatures in the world (phase 1: walking half-way
*           across two cells in the world, by one character on the screen).
move_creatures_phase1_code
    clr  r0
    li   r1, creature_addresses ; Start with the monsters.

* Move monsters.
move_monsters_loop
    mov  *r1, r5               ; Get the monster address.
    jeq  move_monsters_loop_exit ; Didn't we get to the end of the list?
    jlt  move_next_monster     ; Is the monster address still defined?
    movb *r5, r0               ; Is the monster still there?
    ci   r0, monster
    jne  forget_monster
    li   r3, >0004             ; We can try all four directions.
    mov  @>0100(r1), r4        ; Get the current monster direction.
    dect r4

move_monster_loop
    andi r4, >0006             ; Compute the destination direction.
    mov  r5, r2
    a    @direction_offsets(r4), r2
    movb *r2, r0               ; Can't the monster move in that direction?
    ci   r0, soft
    jl   move_monster
    ci   r0, player_front      ; Isn't the player standing there?
    jhe  explode_monster_to_diamond
    ci   r0, lava              ; Isn't there lava?
    jeq  explode_monster_to_dust
    inct r4                    ; Try the next direction.
    dec  r3                    ; Have we tried all four directions?
    jne  move_monster_loop

    li   r4, >0020             ; Don't move at all.
    mov  r4, @>0100(r1)

    inct r1                    ; Continue with the next monster.
    jmp  move_monsters_loop

explode_monster_to_diamond
    blwp @explode_to_diamond

forget_monster
    seto *r1+                  ; Continue with the next monster.
    jmp  move_monsters_loop

explode_monster_to_dust
    blwp @explode_to_dust
    seto *r1+                  ; Continue with the next monster.
    jmp  move_monsters_loop

move_monster
    movb @moving_monster_objects+leaving (r4), *r5 ; Set the monster object half-way leaving a cell.
    movb @moving_monster_objects+entering(r4), *r2 ; Set the monster object half-way entering a cell.
    mov  r4, @>0100(r1)        ; Remember the direction.

move_next_monster
    inct r1                    ; Continue with the next monster.
    jmp  move_monsters_loop

move_monsters_loop_exit
    inct r1                    ; Continue with plain butterflies.

* Move plain butterflies.
move_plain_butterflies_loop
    mov  *r1, r5               ; Get the butterfly address.
    jeq  move_plain_butterflies_loop_exit ; Didn't we get to the end of the list?
    jlt  move_next_plain_butterfly ; Is the butterfly address still defined?
    movb *r5, r0               ; Is the butterfly still there?
    ci   r0, plain_butterfly
    jne  forget_plain_butterfly
    li   r3, >0004             ; We can try all four directions.
    mov  @>0100(r1), r4        ; Get the current butterfly direction.
    dect r4

move_plain_butterfly_loop
    andi r4, >0006             ; Compute the destination direction.
    mov  r5, r2
    a    @direction_offsets(r4), r2
    movb *r2, r0               ; Can't the butterfly move in that direction?
    jeq  move_plain_butterfly
    ci   r0, player_front      ; Isn't the player standing there?
    jhe  explode_plain_butterfly_to_diamond
    ci   r0, lava              ; Isn't there lava?
    jeq  explode_plain_butterfly_to_dust
    inct r4                    ; Try the next direction.
    dec  r3                    ; Have we tried all four directions?
    jne  move_plain_butterfly_loop

    li   r4, >0020             ; Don't move at all.
    mov  r4, @>0100(r1)

    inct r1                    ; Continue with the next butterfly.
    jmp  move_plain_butterflies_loop

explode_plain_butterfly_to_diamond
    blwp @explode_to_diamond

forget_plain_butterfly
    seto *r1+                  ; Continue with the next butterfly.
    jmp  move_plain_butterflies_loop

explode_plain_butterfly_to_dust
    blwp @explode_to_dust
    seto *r1+                  ; Continue with the next butterfly.
    jmp  move_plain_butterflies_loop

move_plain_butterfly
    movb @moving_plain_butterfly_objects+leaving (r4), *r5 ; Set the butterfly object half-way leaving a cell.
    movb @moving_plain_butterfly_objects+entering(r4), *r2 ; Set the butterfly object half-way entering a cell.
    mov  r4, @>0100(r1)        ; Remember the direction.

move_next_plain_butterfly
    inct r1                    ; Continue with the next butterfly.
    jmp  move_plain_butterflies_loop

move_plain_butterflies_loop_exit
    inct r1                    ; Continue with diamond butterflies.

* Move diamond butterflies.
move_diamond_butterflies_loop
    mov  *r1, r5               ; Get the butterfly address.
    jeq  move_diamond_butterflies_loop_exit ; Didn't we get to the end of the list?
    jlt  move_next_diamond_butterfly ; Is the butterfly address still defined?
    movb *r5, r0               ; Is the butterfly still there?
    ci   r0, diamond_butterfly
    jne  forget_diamond_butterfly
    li   r3, >0004             ; We can try all four directions.
    mov  @>0100(r1), r4        ; Get the current butterfly direction.
    dect r4

move_diamond_butterfly_loop
    andi r4, >0006             ; Compute the destination direction.
    mov  r5, r2
    a    @direction_offsets(r4), r2
    movb *r2, r0               ; Can't the butterfly move in that direction?
    jeq  move_diamond_butterfly
    ci   r0, player_front      ; Isn't the player standing there?
    jhe  explode_diamond_butterfly_to_diamond
    ci   r0, lava              ; Isn't there lava?
    jeq  explode_diamond_butterfly_to_diamond
    inct r4                    ; Try the next direction.
    dec  r3                    ; Have we tried all four directions?
    jne  move_diamond_butterfly_loop

    li   r4, >0020             ; Don't move at all.
    mov  r4, @>0100(r1)

    inct r1                    ; Continue with the next butterfly.
    jmp  move_diamond_butterflies_loop

explode_diamond_butterfly_to_diamond
    blwp @explode_to_diamond

forget_diamond_butterfly
    seto *r1+                  ; Continue with the next butterfly.
    jmp  move_diamond_butterflies_loop

move_diamond_butterfly
    movb @moving_diamond_butterfly_objects+leaving (r4), *r5 ; Set the butterfly object half-way leaving a cell.
    movb @moving_diamond_butterfly_objects+entering(r4), *r2 ; Set the butterfly object half-way entering a cell.
    mov  r4, @>0100(r1)        ; Remember the direction.

move_next_diamond_butterfly
    inct r1                    ; Continue with the next butterfly.
    jmp  move_diamond_butterflies_loop

move_diamond_butterflies_loop_exit
    rtwp

* Function: move the creatures in the world (phase 2: walking all the way
*           to the new cell, by one character on the screen).
move_creatures_phase2_code
    clr  r0
    li   r1, creature_addresses
    bl   @move_creature_list_phase2
    data >6800
    bl   @move_creature_list_phase2
    data >7000
    bl   @move_creature_list_phase2
    data >7800
    rtwp

* Subroutine:  move the speficifed list of creatures in the world (phase 2:
*              walking all the way to the new cell).
* IN     data: the creature object completely entering a cell.
* STATIC r0:   the creature object completely leaving a cell.
* STATIC r1:   the pointer to the 0-terminated list of creature addresses.
move_creature_list_phase2
    mov  *r11+, r2

finalize_creature_motion_loop
    mov  *r1, r3
    jeq  finalize_creature_motion_loop_exit
    jlt  skip_disappeared_creature
    movb r0, *r3               ; Set the creature object completely leaving a cell.
    mov  @>0100(r1), r4        ; Compute the new position.
    a    @direction_offsets(r4), r3
    movb r2, *r3               ; Set the creature object completely entering a cell.
    mov  r3, *r1               ; Update the creature position.

skip_disappeared_creature
    inct r1                    ; Continue with the next creature.
    jmp  finalize_creature_motion_loop

finalize_creature_motion_loop_exit
    inct r1
    rt
