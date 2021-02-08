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
* STATIC r10: the current pointer in the list of explosions.
*             An explosion record contains:
*                 word = explosion world address
*                 word = replacement object
clear_explosions
    data explosions_workspace
    data !

!   li   r10, explosion_list
    rtwp

* Function: let the specified object explode to dust.
* IN     r2: the address of the object to explode.
* STATIC r10: the current pointer in the list of explosions.
explode_to_dust
    data explosions_workspace
    data !

!   mov  @calling_r2(r13), *r10+
    li   r0, dust
    mov  r0, *r10+
    blwp @queue_sound
    data explode_to_dust_sound
    rtwp

* Function: let the specified object explode to diamond.
* IN     r2: the address of the object to explode.
* STATIC r10: the current pointer in the list of explosions.
explode_to_diamond
    data explosions_workspace
    data !

!   mov  @calling_r2(r13), *r10+
    li   r0, diamond
    mov  r0, *r10+
    blwp @queue_sound
    data explode_to_diamond_sound
    rtwp

* Function: apply the collected lists of explosions.
* STATIC r10: the current pointer in the list of explosions.
apply_explosions
    data explosions_workspace
    data !

!   li   r0, explosion_list    ; Get the start address.
explosion_loop
    c    r0, r10
    jhe  explosion_exit
    mov  *r0+, r1              ; Get the address of the explosion.
    mov  *r0+, r2              ; Get the replacement object.
    clr  r3                    ; Make sure the LSB of r3 is clear.
    bl   @put_object           ; Replace the central object.
    dec  r1                    ; Replace the left object.
    bl   @put_object
    inct r1                    ; Replace the right object.
    bl   @put_object
    ai   r1, >ffbf             ; Replace the top object.
    bl   @put_object
    dec  r1                    ; Replace the top-left object.
    bl   @put_object
    inct r1                    ; Replace the top-right object.
    bl   @put_object
    ai   r1, >007f             ; Replace the bottom object.
    bl   @put_object
    dec  r1                    ; Replace the bottom-left object.
    bl   @put_object
    inct r1                    ; Replace the bottom-right object.
    bl   @put_object
    jmp  explosion_loop

explosion_exit
    rtwp

* Subroutine: replace any non-solid object at a given address by a given object.
* IN r1: the address of the object to check.
* IN r2: the replacement object.
put_object
    movb *r1, r3
    ci   r3, solid
    jeq  put_object_exit
    movb r2, *r1

put_object_exit
    rt
