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
* Explosion-related functions: let objects explode to dust or to diamond,
* apply the 3x3 explosions in the world.
******************************************************************************

* Function: clear the lists of explosions.
clear_explosions_code
    li   r8, dust_explosion_addresses
    clr  *r8
    li   r9, diamond_explosion_addresses
    clr  *r9
    rtwp

* Function: apply the collected lists of explosions.
apply_explosions_code
    clr  r3                    ; Unused?
    bl   @apply_explosions_list   ; Apply the list of explosions to dust.
    data dust
    data dust_explosion_addresses
    bl   @apply_explosions_list   ; Apply the list of explosions to diamond.
    data diamond
    data diamond_explosion_addresses
    rtwp

* Subroutine: apply explosions at a given list of object addresses.
* IN data: the explosion object (dust, dust,...).
* IN data: the start address of the 0-terminated sequence of addresses.
apply_explosions_list
    mov  *r11+, r0             ; Get the explosion object.
    mov  *r11+, r1             ; Get the start address.
    mov  r11, r10              ; Save the return address.
explosion_loop
    mov  *r1+, r2              ; Get the address of the explosion.
    jeq  explosion_exit
    bl   @put_object           ; Replace the central object.
    dec  r2                    ; Replace the left object.
    bl   @put_object
    inct r2                    ; Replace the right object.
    bl   @put_object
    ai   r2, >ffbf             ; Replace the top object.
    bl   @put_object
    dec  r2                    ; Replace the top-left object.
    bl   @put_object
    inct r2                    ; Replace the top-right object.
    bl   @put_object
    ai   r2, >007f             ; Replace the bottom object.
    bl   @put_object
    dec  r2                    ; Replace the bottom-left object.
    bl   @put_object
    inct r2                    ; Replace the bottom-right object.
    bl   @put_object
    jmp  explosion_loop
explosion_exit
    b    *r10                  ; Return from the subroutine.

* Subroutine: replace any non-solid object at a given address by a given object.
* IN r0: replacement object.
* IN r2: address of the object to check.
put_object
    movb *r2, r3
    ci   r3, solid
    jeq  put_object_exit
    movb r0, *r2

put_object_exit
    rt

* Function: let the specified object explode to dust.
* IN     r2: the address of the object to explode.
* STATIC r8: the pointer of the list of dust explosions.
explode_to_dust_code
    mov  @calling_r2(r13), *r8+
    clr  *r8
    blwp @queue_sound
    data >0066
    rtwp

* Function: let the specified object explode to diamond.
* IN     r2: the address of the object to explode.
* STATIC r8: the pointer of the list of diamond explosions.
explode_to_diamond_code
    mov  @calling_r2(r13), *r9+
    clr  *r9
    blwp @queue_sound
    data >004d
    rtwp
