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
    li   r0, vdp_registers     ; Initialize the VDP registers.
initialize_vdp_loop
    movb *r0+, @vdpwa
    ci   r0, vdp_registers_end
    jne  initialize_vdp_loop

    clr  r0                    ; Write the character patterns.
    li   r1, character_patterns
    li   r2, character_patterns_length
    blwp @vmbw
    a    r2, r0                ; Write a copy of the character patterns.
    blwp @vmbw

    li   r0, >2000             ; Write the character colors.
    a    r2, r1
    blwp @vmbw
    a    r2, r0                ; Write a copy of the character colors.
    blwp @vmbw

    mov  r2, @>834a            ; Reverse the copy of the character patterns.
    mov  r2, @>834c
    blwp @gpllnk
    data >003b

    li   r0, >0400             ; Load the standard character set (>200 bytes).
    mov  r0, @>834a
    blwp @gpllnk
    data >0016

    blwp @vdp_fill             ; Set the character colors to cyan.
    data >2400
    data >7000
    data >0200

    li   r0, >05ff             ; Load the small capitals character set, shifted up 1 pixel.
    mov  r0, @>834a
    blwp @gpllnk
    data >0018

    blwp @vdp_fill             ; Set the character colors to white.
    data >2600
    data >f000
    data >0200

    li   r0, xf00a             ; Compute the checksum of the code. TODO: Remove.
    clr  r1
checksum_loop
    a    *r0+, r1
    ci   r0, xf00a + >0ff6
    jne  checksum_loop

    mov  r1, r1                ; Quit if the checksum is wrong.
    jeq  checksum_ok
    clr  r0
    blwp *r0

checksum_ok
    blwp @initialize_animation_speech_sound
