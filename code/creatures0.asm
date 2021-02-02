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
* Autonomous monsters and butterflies: initialization.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Merge with creatures.asm.

* Subroutine: collect all addresses of the specified creature in the world
*             in a 0-terminated list. Also reset their corresponding
*             directions.
* IN     data:  the creature to look for.
* IN     world: the world that contains the creatures.
* STATIC r2:    the list pointer.
collect_creature_addresses
    mov  *r11+, r1             ; Get the creature object.
    li   r0, world + world_width ; Start looking after the border of the world.

collect_creature_addresses_loop
    cb   r1, *r0               ; Is it the creature we're looking for?
    jne  not_specified_creature
    clr  @>0100(r2)            ; Add the creature direction in the list.
    mov  r0, *r2+              ; Add the creature address to the list.
not_specified_creature
    inc  r0                    ; Loop over all objects of the world.
    ci   r0, world + world_size - world_width
    jne  collect_creature_addresses_loop

collect_creature_addresses_loop_exit
    clr  *r2+                  ; Add the terminating zero.
    rt
