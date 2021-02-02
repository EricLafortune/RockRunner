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
* This file includes all other files that contain code.
* Its start is the entry point for running the game.
******************************************************************************

* The world is a rectangle of 64x32 cells
* (horizontol scanlines, top-to-bottom, left-to-right).
world_height equ 32
world_width  equ 64
world_size   equ world_height * world_width

* Objects, as they are stored in world cells. They may be shifted horizontally
* or vertically, by half an object, through small offsets.
empty                 equ >0000
bomb                  equ >0800
lit_bomb0             equ >1000
lit_bomb1             equ >1800
lit_bomb2             equ >2000
diamond               equ >2800
soft                  equ >3000
lava                  equ >3800
brick                 equ >4000
rock                  equ >4800
concrete              equ >5000
solid                 equ >5800
dust                  equ >6000
monster               equ >6800
plain_butterfly       equ >7000
diamond_butterfly     equ >7800
player_front          equ >8000
player_front_walking  equ >8800
player_right          equ >9000
player_right_walking  equ >9800
player_left           equ >a000
player_left_walking   equ >a800
player_front_blinking equ >b000

* The global memory layout.
world_definitions           equ >a000 ; Part of the program data; must be defined here.
world                       equ >2000 ; The live world.
creature_addresses          equ >2800 ; Three 0-terminated lists: monsters, plain butterflies, diamond butterflies.
creature_directions         equ >2900 ; Corresponding directions.

falling_bomb_addresses      equ >2a00
falling_lit_bomb1_addresses equ >2a80
falling_lit_bomb2_addresses equ >2ac0
falling_diamond_addresses   equ >2b00
falling_rock_addresses      equ >2c00

dust_explosion_addresses    equ >2d00
diamond_explosion_addresses equ >2e00

* Slow workspaces.
util_workspace              equ >2f60
collectables_workspace      equ >2f80 ; Also the main workspace.

* Fast workspaces in scratch pad RAM.
player_workspace            equ >8300
physics_workspace           equ >8320
motion_workspace            equ >8340
rendering_workspace         equ >8360
explosions_workspace        equ >8380
sound_workspace             equ >83a0
gpllnk_workspace            equ >83e0 ; >83f0 later on contains code.

fast_code                   equ >83f0

* Register offsets relative to register base addresses.
calling_r0  equ >0000
calling_r1  equ >0002
calling_r2  equ >0004
calling_r3  equ >0006
calling_r4  equ >0008
calling_r5  equ >000a
calling_r6  equ >000c
calling_r7  equ >000e
calling_r8  equ >0010
calling_r9  equ >0012
calling_r10 equ >0014

* VDP >0000: character pattern definitions.
* VDP >0800: screen.
* VDP >2000: character color definitions.

* Main program.
    lwpi collectables_workspace
    b    @main

* Empty block.
high_score
    data >0000

xf00a
    data >0000 ; Unused.
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000

    copy "util.asm"

    copy "sound_data.asm"
    copy "util2_data.asm"
    copy "rendering_data.asm"
    copy "initialization_data.asm"
    copy "title_screen_data.asm"
    copy "game_screen_data.asm"
    copy "player_data.asm"
    copy "physics_data.asm"
    copy "creatures_data.asm"

    copy "player.asm"
    copy "physics.asm"
    copy "creatures.asm"
    copy "rendering.asm"
    copy "explosions.asm"
    copy "creatures0.asm"
    copy "collectables.asm"
    copy "sound.asm"
    copy "util2.asm"

* The main entry point of the application.
main
    copy "initialization.asm"
    copy "alpha_lock_screen.asm"
    copy "title_screen.asm"
    copy "game_screen.asm"

    copy "workspaces.asm"
