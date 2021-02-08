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
* Program (graphics) initialization.
******************************************************************************

* Block: initialize the VDP registers, character patterns and colors.
* OUT r11: the high score.
    blwp @vdp_write_registers
    data vdp_r0 | >02          ; Mode:                     bitmap.
    data vdp_r2 | >02          ; Screen image table:       >0800.
    data vdp_r3 | >9f          ; Color table:              >2000, half-bitmap.
    data vdp_r4 | >00          ; Pattern descriptor table: >0000, half-bitmap.
    data vdp_r7 | >01          ; Background color:         black.
    data >0000

    blwp @vdp_write_bytes      ; Write the character patterns.
    data 0
    data character_patterns
    data character_patterns_length

    blwp @vdp_write_bytes      ; Write the character colors.
    data >2000
    data character_colors
    data character_patterns_length

    blwp @vdp_write_reversed_bytes ; Write the mirrored character patterns.
    data >0000+character_patterns_length
    data character_patterns
    data character_patterns_length

    blwp @vdp_write_bytes      ; Write the mirrored character colors.
    data >2000+character_patterns_length
    data character_colors
    data character_patterns_length

    blwp @vdp_write_large_character_patterns ; Write the large text character patterns.
    data >0400
    data >04b4

    blwp @vdp_fill             ; Set the large text character colors to cyan.
    data >2400
    data >7000
    data >0200

    blwp @vdp_write_standard_character_patterns ; Write the standard text character patterns.
    data >0600
    data >06B4

    blwp @vdp_fill             ; Set the standard text character colors to white.
    data >2600
    data >f000
    data >0200

    blwp @initialize_animation_speech_sound

    clr  r11                   ; Clear the high score.
