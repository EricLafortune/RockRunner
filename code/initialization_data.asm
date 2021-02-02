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
* VDP initialization data.
******************************************************************************
; TODO: Currently separate to reconstruct the original code. Merge with data/graphics.asm.

* VDP registers (value, >80 | register number).
vdp_registers
    data >0280 ; VDP r0 (mode)                     = >02 (bitmap)
    data >0282 ; VDP r2 (screen image table)       = >02 (>0800)
    data >9f83 ; VDP r3 (color table)              = >9f (>2000, half-bitmap)
    data >0084 ; VDP r4 (pattern descriptor table) = >00 (>0000, half-bitmap)
    data >0187 ; VDP r7 )background color)         = >01 (black)
vdp_registers_end
