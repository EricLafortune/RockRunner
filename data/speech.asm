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
* Speech definiitions: random phrases and the speech data for those phrases.
******************************************************************************

; A random speech phrase definition is a sequence of words:
;     word = random number bound.
;     word = actual number of speech phrases (otherwise silence).
;         word = offset into the speech phrase definitions.
;         ...

random_speech_definitions
x32a0
    data >0004 ; Start.
    data >0003
    data >0006
    data >000a
    data >000e

x32aa
    data >000a ; Player not moving for some time.
    data >0007
    data >0012
    data >0016
    data >001c
    data >0022
    data >0028
    data >002e
    data >0034

x32bc
    data >0001 ; Almost out of time.
    data >0001
    data >003e

x32c2
    data >0002 ; Out of time.
    data >0002
    data >0044
    data >004e

x32ca
    data >0004 ; Collected the required number of diamonds.
    data >0004
    data >0056
    data >005a
    data >0060
    data >0066

x32d6
    data >000d ; Died.
    data >000d
    data >006c
    data >0070
    data >0074
    data >0078
    data >007c
    data >0080
    data >0084
    data >0088
    data >008e
    data >0094
    data >009c
    data >00a4
    data >00ac

x32f4
    data >0000 ; Unused.
    data >0000
    data >0000
    data >0000
    data >0000
    data >0000

; A speech phrase definition is a sequence of words:
;     ...   = speech phrase data.
;     >0000 = terminating zero for the data.

speech_definitions
x3300
    data >2bd7
    data >6fbb
    data >0000

x3306
    data >2ffc
    data >0000

x330a
    data >637c
    data >0000

x330e
    data >56b3
    data >0000

x3312
    data >351a
    data >0000

x3316
    data >1e54
    data >4c41
    data >0000

x331c
    data >2ffc
    data >4c41
    data >0000

x3322
    data >46df
    data >4c41
    data >0000

x3328
    data >78f4
    data >76b0
    data >0000

x332e
    data >77bc
    data >4ada
    data >0000

x3334
    data >71be
    data >556e
    data >6489
    data >4fe5
    data >0000

x333e
    data >5093
    data >3757
    data >0000

x3344
    data >7e4d
    data >6e69
    data >3a32
    data >739f
    data >0000

x334e
    data >3c4f
    data >6e69
    data >3e78
    data >0000

x3356
    data >30fa
    data >0000

x335a
    data >7717
    data >253e
    data >0000

x3360
    data >5bfb
    data >1fcd
    data >0000

x3366
    data >4959
    data >5bfb
    data >0000

x336c
    data >71f4
    data >0000

x3370
    data >61c6
    data >0000

x3374
    data >3571
    data >0000

x3378
    data >3148
    data >0000

x337c
    data >49a5
    data >0000

x3380
    data >700f
    data >0000

x3384
    data >77e9
    data >0000

x3388
    data >4b7d
    data >3c4f
    data >0000

x338e
    data >4642
    data >4642
    data >0000

x3394
    data >78ab
    data >556e
    data >71be
    data >0000

x339c
    data >3793
    data >3f2f
    data >67b6
    data >0000

x33a4
    data >1c48
    data >1c48
    data >4ee0
    data >0000

x33ac
    data >71be
    data >775c
    data >360a

silence_definition
    data >0000
