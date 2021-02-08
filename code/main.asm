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

* The GROM layout.
grom_world_definitions            equ >6000 ; The compressed world definitions in GROM.
grom_world_definition_size        equ >0400 ; The size of a compressed world definition.
grom_world_definition_size_shift  equ 10    ; The multiplicative shift of the size.

* The VDP RAM layout.

vdp_pattern_table equ >0000 ; 256 * 8 bytes with bitmap patterns.
vdp_color_table   equ >2000 ; 256 * 8 bytes with corresponding bitmap colors.
vdp_screen_table  equ >0800 ; 24 * 32 bytes with the defined characters.

* The CPU RAM layout.
world                       equ >2000 ; The live world.
creature_addresses          equ >2800 ; Three 0-terminated lists: monsters, plain butterflies, diamond butterflies.
creature_directions         equ >2a00 ; Corresponding directions.

falling_object_list         equ >2c00
explosion_list              equ >2e00

high_score                  equ >2efe

* Workspaces.
main_workspace              equ >8300          ; We don't need r13-r15 here.
player_workspace            equ >8320
physics_workspace           equ >8340
creatures_workspace         equ >8360
rendering_workspace         equ >8380
explosions_workspace        equ >83a0          ; A slower workspace.
collectables_workspace      equ main_workspace ; We can still use r13-r15 here.
sound_workspace             equ >83c0
util_workspace              equ >83e0

fast_code                   equ >83ec          ; Dangerously overlapping with
                                               ; the util workspace.

    copy "util_definitions.asm"

* The main entry point of the application.
main
    ; The main code block, with subsequent screens.
    lwpi main_workspace
    copy "initialization.asm"
    copy "alpha_lock_screen.asm"
    copy "title_screen.asm"
    copy "game_screen.asm"

    ; Functions and subroutines.
    copy "player.asm"
    copy "physics.asm"
    copy "creatures.asm"
    copy "rendering.asm"
    copy "explosions.asm"
    copy "collectables.asm"
    copy "sound.asm"
    copy "util.asm"
