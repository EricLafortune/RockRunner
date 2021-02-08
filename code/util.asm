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
* VDP and GROM support functions.
******************************************************************************

* Function: the traditional VDP Single Byte Write.
* IN r0: the VDP destination address.
* IN r1: the byte.
vsbw
    data util_workspace
    data !

!   mov  *r13, r0
    ori  r0, >4000
    .vdpwa r0
    nop
    movb @calling_r1(r13), @vdpwd
    rtwp

* Function: the traditional VDP Multiple Byte Write.
* IN r0: the VDP destination address.
* IN r1: the CPU source address.
* IN r2: the number of bytes.
vmbw
    data util_workspace
    data !

!   mov  *r13, r0
    mov  @calling_r1(r13), r1
    mov  @calling_r2(r13), r2
    ori  r0, >4000
    .vdpwa r0
    nop
vmbw_loop
    movb *r1+, @vdpwd
    dec  r2
    jne  vmbw_loop
    rtwp

* Function: write VDP registers, with hard-coded arguments.
* IN data: a VDP register definition (register in the MSB,
*          value in the LSB).
* IN ...
* IN data: >0000 = terminator
vdp_write_registers
    data util_workspace
    data !

!   mov  *r14+, r0
vdp_write_registers_loop
    .vdpwa r0
    mov  *r14+, r0
    jne  vdp_write_registers_loop
    rtwp

* Function: write multiple bytes to VDP memory, with hard-coded arguments.
* IN data: the VDP destination address.
* IN data: the CPU source address.
* IN data: the number of bytes.
vdp_write_bytes
    data util_workspace
    data !

!   mov  *r14+, r0
    mov  *r14+, r1
    mov  *r14+, r2

    ori  r0, >4000
    .vdpwa r0

vdp_write_bytes_loop
    movb *r1+, @vdpwd
    dec  r2
    jne  vdp_write_bytes_loop
    rtwp

* Funtion: fill a specified block of memory with a given value.
* IN data: the VDP destination address.
* IN data: the byte value (in MSB).
* IN data: the length.
vdp_fill
    data util_workspace
    data !

!   mov  *r14+, r0             ; Get the VDP address.
    mov  *r14+, r1             ; Get the value.
    mov  *r14+, r2             ; Get the length.

    ori  r0, >4000             ; Write the address.
    .vdpwa r0
    nop

vdp_fill_loop
    movb r1, @vdpwd            ; Write the value.
    dec  r2
    jne  vdp_fill_loop
    rtwp

* Function: write multiple reversed bytes to VDP memory, with hard-coded arguments.
*           Typically useful to write mirrored character patterns.
* IN data: the VDP destination address.
* IN data: the CPU source address.
* IN data: the number of bytes.
vdp_write_reversed_bytes
    data util_workspace
    data !

!   mov  *r14+, r0
    mov  *r14+, r1
    mov  *r14+, r2

    ori  r0, >4000
    .vdpwa r0

vdp_write_reversed_bytes_loop
    movb *r1+, r0

    mov  r0, r3                ; Swap 4-bits, from >ff00 to >0ff0.
    srl  r3, 8
    andi r0, >0f00
    andi r3, >00f0
    soc  r3, r0

    mov  r0, r3                ; Swap 2-bits, from >0ff0 to >03fc.
    srl  r3, 4
    andi r0, >0330
    andi r3, >00cc
    soc  r3, r0

    mov  r0, r3                ; Swap 1-bits, from >03fc to >01fe.
    srl  r3, 2
    andi r0, >0154
    andi r3, >00aa
    soc  r3, r0

    sla  r0, 7                 ; Shift >01fe back to >ff00.

    movb r0, @vdpwd
    dec  r2
    jne  vdp_write_reversed_bytes_loop
    rtwp

* Function: write the large chracter patterns to VDP memory
*           (64 characters, starting with the space character).
* IN data: the VDP destination address.
vdp_write_large_character_patterns
    data util_workspace
    data !

!   mov  *r14+, r0
    ori  r0, >4000
    .vdpwa r0

    mov  *r14+, r0
    movb r0, @grmwa
    swpb r0
    movb r0, @grmwa

    li r0, 64*8

vdp_write_large_character_patterns_loop
    movb @grmrd, @vdpwd
    dec  r0
    jne  vdp_write_large_character_patterns_loop
    rtwp

* Function: write the standard chracter patterns to VDP memory
*           (64 characters, starting with the space character).
*           The 1-pixel vertical whitespace is added at the bottom.
* IN data: the VDP destination address.
vdp_write_standard_character_patterns
    data util_workspace
    data !

!   mov  *r14+, r0
    ori  r0, >4000
    .vdpwa r0

    mov  *r14+, r0
    .grmwa r0

    li r0, 64

vdp_write_standard_character_patterns_loop
    movb @grmrd, @vdpwd
    nop
    movb @grmrd, @vdpwd
    nop
    movb @grmrd, @vdpwd
    nop
    movb @grmrd, @vdpwd
    nop
    movb @grmrd, @vdpwd
    nop
    movb @grmrd, @vdpwd
    nop
    movb @grmrd, @vdpwd
    nop
    movb r0, @vdpwd            ; The MSB contains >00.
    dec  r0
    jne  vdp_write_standard_character_patterns_loop
    rtwp

* Function: draw blocks of text.
* IN data: the VDP destination address.
* IN data: the address of the text definitions.
draw_text
    data sound_workspace       ; We need to borrow a workspace.
    data !

!   mov  *r14+, r0             ; Get the VDP destination address.
    mov  *r14+, r3             ; Get the text definitions address.
    mov  *r3+, r1              ; Get the strings address.

draw_text_loop
    movb *r3+, r2              ; Get the length.
    srl  r2, 8
    blwp @vmbw
    a    r2, r1                ; Increment the CPU source address.
    movb *r3+, r2
    jeq  draw_text_loop_exit
    srl  r2, 8
    a    r2, r0                ; Increment the VDP destination address.
    jmp  draw_text_loop

draw_text_loop_exit
    rtwp

* Function: draw the given value as a decimal number in VDP memory.
* IN data: the VDP destination adress of the last digit.
* IN r0:   the value.
draw_decimal
    data sound_workspace       ; We need to borrow a workspace.
    data !

!   mov  *r14+, r0
    mov  *r13, r3
    li   r4, 10

draw_decimal_loop
    clr  r2                    ; Clear the top register.
    div  r4, r2                ; Divide the value by 10.
    mov  r3, r1                ; Convert the remainder to a digit.
    swpb r1
    ai   r1, >d000
    blwp @vsbw                 ; Write the digit.
    dec  r0
    mov  r2, r3                ; Continue computing with the remainder, if any.
    jne  draw_decimal_loop

    clr  r1                    ; Prepend a space.
    blwp @vsbw

    rtwp
