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
* More VDP support functions: fill VDP memory blocks, draw the game title.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Merge with util.asm.

* Funtion: fill a specified block of memory with a given value.
* IN data: the VDP address.
* IN data: the byte value (in MSB).
* IN data: the length.
vdp_fill_code
    mov  *r14+, r0             ; Get the VDP address.
    mov  *r14+, r1             ; Get the value.
    mov  *r14+, r2             ; Get the length.

    ori  r0, >4000             ; Write the address.
    swpb r0
    movb r0, @vdpwa
    swpb r0
    movb r0, @vdpwa
    nop

vdp_fill_data_loop
    movb r1, @vdpwd            ; Write the value.
    dec  r2
    jne  vdp_fill_data_loop
    rtwp

* Function: draw the title in large block characters.
* IN data: the VDP destination address.
draw_title_code
    mov  *r14+, r0             ; Get the VDP destination address.

    li   r1, title_characters  ; Draw the top line.
    li   r2, 14
    bl   @draw_title_line

    ai   r0, >0040             ; Draw the bottom line.
    li   r2, 17
    bl   @draw_title_line
    rtwp

* Subroutine: draw a line of the title (3 subsequent character spans of the
*             same length).
* STATIC r0: the VDP destination address.
* STATIC r1: the CPU memory source address.
* IN     r2: the length.
draw_title_line
    li   r3, >0003             ; We'll copy 3 sequences.

draw_title_line_loop
    blwp @vmbw                 ; Write a sequence.
    ai   r0, >0020
    a    r2, r1
    dec  r3                    ; Loop until all sequences have been written.
    jne  draw_title_line_loop

    rt

* Function: draw the given value as a decimal number in VDP memory.
* IN data: the VDP destination adress of the last digit.
* IN r0:   the value.
draw_decimal_code
    mov  *r14+, r0
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

* Empty block.
    data >0000 ; Unused.
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000
