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
* Workspace defintions for all functions.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Move to the corresponding files.

* Player.
initial_scroll
    data player_workspace
    data initial_scroll_code

initialize_screen_position ; TODO: Part of the rendering functions.
    data rendering_workspace
    data initialize_screen_position_code

move_player_phase1
    data player_workspace
    data move_player_phase1_code

move_player_phase2
    data player_workspace
    data move_player_phase2_code

* Physics.
apply_physics
    data physics_workspace
    data apply_physics_code

land_falling_objects
    data physics_workspace
    data land_falling_objects_code

* Creatures.
move_creatures_phase1
    data motion_workspace
    data move_creatures_phase1_code

move_creatures_phase2
    data motion_workspace
    data move_creatures_phase2_code

* Rendering.
draw_world
    data rendering_workspace
    data draw_world_code

* Explosions.
clear_explosions
    data explosions_workspace
    data clear_explosions_code

apply_explosions
    data explosions_workspace
    data apply_explosions_code

explode_to_dust
    data explosions_workspace
    data explode_to_dust_code

explode_to_diamond
    data explosions_workspace
    data explode_to_diamond_code

* Collectables: diamonds, bombs, time, score, world, lives.
collect_diamond
    data collectables_workspace
    data collect_diamond_code

collect_bomb
    data collectables_workspace
    data collect_bomb_code

drop_bomb
    data collectables_workspace
    data drop_bomb_code

* Speech, sound, color animations, utilities.
play_sounds
    data sound_workspace
    data play_sounds_code

initialize_animation_speech_sound
    data sound_workspace
    data initialize_animation_speech_sound_code

update_animation_speech_sound
    data sound_workspace
    data update_animation_speech_sound_code

update_speech_sound
    data sound_workspace
    data update_speech_sound_code

queue_random_speech
    data sound_workspace
    data queue_random_speech_code

queue_sound
    data sound_workspace
    data queue_sound_code

play_lava_sound
    data sound_workspace
    data play_lava_sound_code

* Util2.
vdp_fill
    data sound_workspace
    data vdp_fill_code

draw_title
    data sound_workspace
    data draw_title_code

draw_decimal
    data sound_workspace
    data draw_decimal_code
