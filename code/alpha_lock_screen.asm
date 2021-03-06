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
* The alpha lock screen.
******************************************************************************

* Block: draw the alpha lock warning screen until the alpha lock key is
*        released, to avoid the hardware conflict that disables the joystick
*        up detection.
alpha_lock_screen
    clr  r12                   ; Is the alpha lock down?
    sbz  21
    tb   7
    jeq  alpha_lock_up

    blwp @vdp_fill             ; Clear the screen.
    data >0800
    data >0000
    data >0300

    blwp @draw_text            ; Draw the game title.
    data >08c7
    data title_definitions

    li   r0, >0a47             ; Display a warning.
    li   r1, alpha_lock_string
    li   r2, 18
    blwp @vmbw

alpha_lock_loop
    tb   7                     ; Loop while the alpha lock is down.
    jne  alpha_lock_loop

alpha_lock_up
    sbo  21

    blwp @vdp_fill             ; Clear the screen.
    data >0800
    data >0000
    data >0300
