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
* Standard VDP amd GPL definitions and support functions.
******************************************************************************

vdpwa   equ  >8c02
vdpwd   equ  >8c00

sound   equ  >8400
spchrd  equ  >9000
spchwt  equ  >9400

* VDP Single Byte Write.
vsbw_code
    mov  *r13, r0
    ori  r0, >4000
    swpb r0
    movb r0, @vdpwa
    swpb r0
    movb r0, @vdpwa
    nop
    movb @calling_r1(r13), @vdpwd
    rtwp

* VDP Multiple Byte Write.
vmbw_code
    mov  *r13, r0
    mov  @calling_r1(r13), r1
    mov  @calling_r2(r13), r2
    ori  r0, >4000
    swpb r0
    movb r0, @vdpwa
    swpb r0
    movb r0, @vdpwa
    nop
vmbw_loop
    movb *r1+, @vdpwd
    dec  r2
    jne  vmbw_loop
    rtwp

* GPL Link.
* OVERWRITES main r2
* OVERWITES rendering r9
gpllnk_code
    movb @>8373, r1
    srl  r1, 8
    mov  *r14+, @>8304(r1)
    li   r0, >2000
    socb r0, @>8349
    li   r0, gpllnk_return
    mov  r0, @>2002
    lwpi gpllnk_workspace
    li   r6, >6892
    b    @>0060
gpllnk_return
    lwpi util_workspace
    rtwp

* Workspaces.
vsbw
    data util_workspace
    data vsbw_code

vmbw
    data util_workspace
    data vmbw_code

gpllnk
    data util_workspace
    data gpllnk_code
