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
* Definitions and macros for accessing the VDP, GROM,...
******************************************************************************

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

* VDP register write addresses (including the register bit >8000).
vdp_r0 equ >8000
vdp_r1 equ >8100
vdp_r2 equ >8200
vdp_r3 equ >8300
vdp_r4 equ >8400
vdp_r5 equ >8500
vdp_r6 equ >8600
vdp_r7 equ >8700

* VDP addresses.
vdpwa  equ  >8c02
vdprd  equ  >8800
vdpwd  equ  >8c00
vdpsta equ  >8802

* GROM addresses.
grmwa  equ  >9c02
grmra  equ  >9802
grmrd  equ  >9800
grmwd  equ  >9c00

* Sound address.
sound  equ  >8400

* Speech addresses.
spchrd equ  >9000
spchwt equ  >9400

* Macro: write the given VDP address.
* IN #1: the register containing the aVDP address
*        (including the register bit >8000 or write bit >4000 if necessary).
    .defm vdpwa
    swpb #1
    movb #1, @vdpwa
    swpb #1
    movb #1, @vdpwa
    .endm

* Macro: write the given valie to the given VDP register.
* IN #1:  the register number.
* IN #2:  the register value.
* OUT r0: the VDP address.
*        (including the register bit >8000 ot write bit >4000 if necessary).
    .defm vdpwr
    li   r0, #2 * 256 + >0080 + #1
    movb r0, @vdpwa
    swpb r0
    movb r0, @vdpwa
    .endm

* Macro: write the given GROM address.
* IN #1: the register containing the the GROM address.
    .defm grmwa
    movb #1, @grmwa
    swpb #1
    movb #1, @grmwa
    swpb #1
    .endm

* Macro: read a word (MSB first) from the current GROM address.
* OUT #1: the register in which to store the read word.
    .defm grmrd
    movb @grmrd, #1
    swpb #1
    movb @grmrd, #1
    swpb #1
    .endm
