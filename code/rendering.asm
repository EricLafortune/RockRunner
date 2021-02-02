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
* The rendering engine: draw a visible part of the world (64x32 cells with
* objects of 2x2 screen chracters) on the screen (32x22 characters),
* incrementally scrolling if necessary to keep the player in view.
******************************************************************************

* Function: draw the objects, and scroll the screen if necessary.
* STATIC r0:      screen y position.
* STATIC r1:      screen x position.
* IN     main r8: player y position.
* IN     main r9: player x position.
draw_world_code
    li   r2, >4048
    movb r2, @vdpwa
    swpb r2
    movb r2, @vdpwa
    li   r8, vdpwd             ; Cache the vdpwd address.
    mov  r0, r2                ; Compute the offset of the first object: world + y * world_width + x.
    sla  r2, 6
    a    r1, r2
    ai   r2, world
    mov  @player_workspace+calling_r8, r4
    mov  @player_workspace+calling_r9, r5
    ai   r4, >fffd
    ai   r5, >fffc
    c    r4, r0                ; Should we  scroll up?
    jgt  no_scroll_up
    mov  r0, r0                ; Did we reach the top?
    jeq  no_scroll_up
    dec  r0                    ; Scroll up.
    jmp  draw_world_shifted_down
no_scroll_up
    c    r5, r1                ; Should we scroll left?
    jgt  no_scroll_up_left
    mov  r1, r1                ; Did we reach the left?
    jeq  no_scroll_up_left
    dec  r1                    ; Scroll left.
    jmp  draw_world_shifted_right
no_scroll_up_left
    ai   r4, >fffc
    ai   r5, >fff9
    c    r4, r0                ; Should we scroll down?
    jlt  no_scroll_up_left_down
    ci   r0, >0015             ; Did we reach the bottom?
    jeq  no_scroll_up_left_down
    inc  r0                    ; Scroll down.
    jmp  draw_world_shifted_up
no_scroll_up_left_down
    c    r5, r1                ; Should we scroll right?
    jlt  draw_world_unshifted
    ci   r1, >0030             ; Did we reach the right?
    jeq  draw_world_unshifted
    inc  r1                    ; Scroll right.
    jmp  draw_world_shifted_left

* Draw the objects, without shifts from scrolling.
draw_world_unshifted
    li   r4, >000b             ; We'll draw 11 object lines (2 characters high),
draw_scanlines_loop
    li   r5, >0010             ; We'll draw 16 objects (2 characters wide).
draw_scanline_loop1
    movb *r2+, r6              ; Retrieve the object.
    srl  r6, 8
    movb @object_characters+top_left(r6), *r8 ; Draw the top 2 characters of the object.
    movb @object_characters+top_right(r6), *r8
    dec  r5
    jne  draw_scanline_loop1
    ai   r2, >fff0             ; Draw the second scanline.
    li   r5, >0010             ; We'll draw the same 16 objects (2 characters wide).
draw_scanline_loop2
    movb *r2+, r6              ; Retrieve the object.
    srl  r6, 8
    movb @object_characters+bottom_left(r6), *r8  ; Draw the bottom 2 characters of the object.
    movb @object_characters+bottom_right(r6), *r8
    dec  r5
    jne  draw_scanline_loop2
    ai   r2, >0030
    dec  r4
    jne  draw_scanlines_loop
    rtwp

* Draw the objects, shifted vertically by one character.
draw_world_shifted_down
    ai   r2, >ffc0
draw_world_shifted_up
    li   r4, >000b             ; We'll draw 11 object lines (2 characters high),
draw_scanlines_v_loop
    li   r5, >0010             ; We'll draw 16 objects (2 characters wide).
draw_scanline_v_loop1
    movb *r2+, r6              ; Retrieve the object.
    srl  r6, 8
    movb @object_characters+bottom_left(r6), *r8  ; Draw the bottom 2 characters of the object.
    movb @object_characters+bottom_right(r6), *r8
    dec  r5
    jne  draw_scanline_v_loop1
    ai   r2, >0030             ; Draw the second scanline.
    li   r5, >0010             ; We'll draw the next 16 objects (2 characters wide).
draw_scanline_v_loop2
    movb *r2+, r6              ; Retrieve the object.
    srl  r6, 8
    movb @object_characters+top_left(r6), *r8 ; Draw the top 2 characters of the object.
    movb @object_characters+top_right(r6), *r8
    dec  r5
    jne  draw_scanline_v_loop2
    ai   r2, >fff0
    dec  r4
    jne  draw_scanlines_v_loop
    rtwp

* Draw the objects, shifted horizontally by one character.
draw_world_shifted_right
    dec  r2
draw_world_shifted_left
    li   r4, >000b             ; We'll draw 11 object lines (2 characters high),
draw_scanlines_h_loop
    li   r5, >0010             ; We'll draw 17 objects (2 characters wide).
    movb *r2+, r6              ; Retrieve the first object.
    srl  r6, 8
draw_scanline_h_loop1
    movb @object_characters+top_right(r6), *r8 ; Draw the top right character of the object.
    movb *r2+, r6              ; Retrieve the next object.
    srl  r6, 8
    movb @object_characters+top_left(r6), *r8  ; Draw the top left character of the object.
    dec  r5
    jne  draw_scanline_h_loop1
    ai   r2, >ffef             ; Draw the second scanline.
    li   r5, >0010             ; We'll draw the same 17 objects (2 characters wide).
    movb *r2+, r6              ; Retrieve the first object.
    srl  r6, 8
draw_scanline_h_loop2
    movb @object_characters+bottom_right(r6), *r8 ; Draw the bottom right character of the object.
    movb *r2+, r6              ; Retrieve the next object.
    srl  r6, 8
    movb @object_characters+bottom_left(r6), *r8  ; Draw the bottom left character of the object.
    dec  r5
    jne  draw_scanline_h_loop2
    ai   r2, >002f
    dec  r4
    jne  draw_scanlines_h_loop
    rtwp
