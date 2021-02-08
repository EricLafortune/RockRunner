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
* Graphics definitions: objects -> characters -> patterns and colors.
******************************************************************************

heart_character equ >2900

* Offsets in the records below.
leaving  equ 0
entering equ 1

* Animated creature objects (indexing in the object characxter table below).
moving_monster_objects
    data >656b                    ; Right.
    data >6967                    ; Up.
    data >6b65                    ; Left.
    data >6769                    ; Down.

moving_plain_butterfly_objects
    data >6d73                    ; Right.
    data >716f                    ; Up.
    data >736d                    ; Left.
    data >6f71                    ; Down.

moving_diamond_butterfly_objects
    data >757b                    ; Right.
    data >7977                    ; Up.
    data >7b75                    ; Left.
    data >7779                    ; Down.

* Offets in the object character records below. The 2x2 charqcters are stored
* as a sequence of bytes
*     top_left bottom_left >00 top_right bottom_right
* to allow reusing the same sequence with different offsets for scrolled
* versions of the object.
top_left     equ 0
bottom_left  equ 1
top_right    equ 3
bottom_right equ 4

* Characters that correspond to the objects.
object_characters
    data >0000 ; Empty.
    data >0000
    data >0000
    data >0000
    data >0102 ; Bomb.
    data >0003
    data >0400
    data >0000
    data >0502 ; Lit bomb0.
    data >0006
    data >0400
    data >0000
    data >3002 ; Lit bomb1.
    data >002f
    data >0400
    data >0000
    data >0502 ; Lit bomb2.
    data >0006
    data >0400
    data >0000
    data >0708 ; Diamond.
    data >0031
    data >3200
    data >0000
    data >0933 ; Soft.
    data >0009
    data >3300
    data >0000
    data >0a0a ; Lava.
    data >000a
    data >0a00
    data >0000
    data >0b0b ; Brick.
    data >000b
    data >0b00
    data >0000
    data >0c0d ; Rock.
    data >000e
    data >0f00
    data >0000
    data >1010 ; Concrete.
    data >003a
    data >3a00
    data >0000
    data >1111 ; Solid.
    data >0011
    data >1100
    data >0000
    data >1213 ; Dust.
    data >003c
    data >3d00
    data >0000
    data >1415 ; Monster.
    data >003e
    data >3f00
    data >0000
    data >1617 ; Plain butterfly.
    data >0040
    data >4100
    data >0000
    data >1819 ; Diamond butterfly.
    data >0042
    data >4300
    data >0000
    data >1a1b ; Player front.
    data >0044
    data >4500
    data >0000
    data >1a1c ; Player front walking.
    data >0044
    data >1d00
    data >0000
    data >1e1f ; Player right.
    data >0020
    data >2100
    data >0000
    data >1e22 ; Player right walking.
    data >0020
    data >2300
    data >0000
    data >4a4b ; Player left.
    data >0048
    data >4900
    data >0000
    data >4a4d ; Player left walking.
    data >0048
    data >4c00
    data >0000
    data >241b ; Player front blinking.
    data >004e
    data >4500
    data >0000

character_patterns_length equ >0150

* Patterns that define the characters.
character_patterns
    byte :00000000 ; Empty.
    byte :00000000
    byte :00000000
    byte :00000000
    byte :00000000
    byte :00000000
    byte :00000000
    byte :00000000

    byte :00000000 ; Bomb.
    byte :00000000
    byte :00000000
    byte :00000000
    byte :00000000
    byte :00000000
    byte :00000011
    byte :00001111

    byte :00001111
    byte :00011100
    byte :00011101
    byte :00011111
    byte :00011111
    byte :00001111
    byte :00001111
    byte :00000011

    byte :00000000
    byte :00100000
    byte :01000000
    byte :01000000
    byte :10000000
    byte :10000000
    byte :11000000
    byte :11110000

    byte :11110000
    byte :11111000
    byte :11111000
    byte :11111000
    byte :11111000
    byte :11110000
    byte :11110000
    byte :11000000

    byte :00001100 ; Lit bomb.
    byte :00000110
    byte :00000000
    byte :00011100
    byte :00001110
    byte :00000000
    byte :00000011
    byte :00001111

    byte :11000110
    byte :10001100
    byte :01100001
    byte :01100111
    byte :10010000
    byte :10011100
    byte :11000100
    byte :11110000

    byte :00000011 ; Diamond.
    byte :00000111
    byte :00001111
    byte :00011111
    byte :00111111
    byte :01111111
    byte :11111111
    byte :11111111

    byte :11111111
    byte :11111111
    byte :01111111
    byte :00111111
    byte :00011111
    byte :00001111
    byte :00000111
    byte :00000011

    byte :11001001 ; Soft.
    byte :00100100
    byte :11010011
    byte :10010110
    byte :01101001
    byte :01101011
    byte :10100101
    byte :10011010
lava_pattern1
    byte :01000000 ; Lava.
    byte :11100000
    byte :01000100
    byte :00000000
    byte :00000010
    byte :00000111
    byte :00100010
    byte :00000000

    byte :11101111 ; Brick.
    byte :11101111
    byte :11101111
    byte :00000000
    byte :11111110
    byte :11111110
    byte :11111110
    byte :00000000

    byte :00001111 ; Rock.
    byte :00111111
    byte :01111111
    byte :01111111
    byte :11111110
    byte :11111111
    byte :11111111
    byte :11011111

    byte :11011111
    byte :11101111
    byte :11111111
    byte :11111111
    byte :01111111
    byte :01111111
    byte :00111111
    byte :00001111

    byte :11110000
    byte :11111100
    byte :11111110
    byte :11111110
    byte :11111111
    byte :11111111
    byte :11111111
    byte :11111011

    byte :11111001
    byte :11110011
    byte :11110111
    byte :11001111
    byte :11111110
    byte :11111110
    byte :11111100
    byte :11110000

    byte :00010001 ; Concrete.
    byte :01000100
    byte :00010000
    byte :10100010
    byte :00001000
    byte :01000000
    byte :00010001
    byte :01000100

    byte :11111111 ; Solid.
    byte :10011001
    byte :10011001
    byte :11111111
    byte :11111111
    byte :10011001
    byte :10011001
    byte :11111111

    byte :00000000 ; Dust.
    byte :00000011
    byte :00001100
    byte :00110010
    byte :00101001
    byte :01001010
    byte :01100111
    byte :00110111

    byte :01000101
    byte :00101011
    byte :00100110
    byte :00111001
    byte :00010000
    byte :00001101
    byte :00000010
    byte :00000000

    byte :00110000 ; Monster.
    byte :01001000
    byte :10001111
    byte :00011111
    byte :00011111
    byte :00011011
    byte :00011001
    byte :00111111

    byte :00111111
    byte :01111111
    byte :01111111
    byte :11111100
    byte :10001111
    byte :10010100
    byte :01001010
    byte :00101010

    byte :01100000 ; Plain butterfly.
    byte :11110000
    byte :11111000
    byte :11111101
    byte :11111111
    byte :11111111
    byte :11100111
    byte :11000011

    byte :11000011
    byte :11100111
    byte :11111111
    byte :11111111
    byte :11111101
    byte :11111000
    byte :11110000
    byte :01100000

    byte :00110000 ; Diamonad butterfly.
    byte :01111000
    byte :01111100
    byte :11111110
    byte :11111100
    byte :11111000
    byte :11110000
    byte :11100000

    byte :11100000
    byte :11110000
    byte :11111000
    byte :11111100
    byte :11111110
    byte :01111100
    byte :01111000
    byte :00110000

    byte :00011111 ; Player front.
    byte :01111111
    byte :00000110
    byte :00001110
    byte :00001010
    byte :00000011
    byte :00000111
    byte :10000111

    byte :00000111
    byte :00110011
    byte :11100111
    byte :01101111
    byte :00001110
    byte :00001100
    byte :00111110
    byte :01111110

    byte :00000111 ; Legs front walking.
    byte :00110011
    byte :11100111
    byte :01101111
    byte :01111100
    byte :11111100
    byte :00000001
    byte :00000001

    byte :11100000
    byte :11001100
    byte :11100111
    byte :11100110
    byte :01100000
    byte :11000000
    byte :11110000
    byte :11111000

    byte :00011111 ; Player right.
    byte :00111111
    byte :00111111
    byte :01111111
    byte :11111110
    byte :11111100
    byte :11111000
    byte :01111111

    byte :00111111
    byte :00111111
    byte :00011111
    byte :00001111
    byte :00000111
    byte :00000111
    byte :00001111
    byte :00001111

    byte :11110000
    byte :11111000
    byte :11100000
    byte :11100000
    byte :10101100
    byte :11111110
    byte :11111110
    byte :11111110

    byte :11011100
    byte :11000000
    byte :11000000
    byte :10000000
    byte :10000000
    byte :10000000
    byte :11100000
    byte :11110000

    byte :00111111 ; Legs right walking.
    byte :00111111
    byte :00011111
    byte :00111111
    byte :00111111
    byte :00111101
    byte :01111100
    byte :01111110

    byte :11011100
    byte :11000000
    byte :11000000
    byte :11000000
    byte :11100000
    byte :11100000
    byte :11111000
    byte :11111100

    byte :00011111 ; Face blinking.
    byte :01111111
    byte :00000110
    byte :00001110
    byte :00001110
    byte :00000011
    byte :00000111
    byte :10000111

    byte :11111110 ; Font vertical bar.
    byte :11111110
    byte :11111110
    byte :11111110
    byte :11111110
    byte :11111110
    byte :11111110
    byte :11111110

    byte :00000110 ; Font top left rounded.
    byte :00011110
    byte :00111110
    byte :01111110
    byte :01111110
    byte :11111110
    byte :11111110
    byte :11111110

    byte :11111110 ; Font center left rounded.
    byte :11111110
    byte :01111110
    byte :00011110
    byte :01111110
    byte :11111110
    byte :11111110
    byte :11111110

    byte :11111110 ; Font bottom left rounded.
    byte :11111110
    byte :11111110
    byte :01111110
    byte :01111110
    byte :00111110
    byte :00011110
    byte :00000110

    byte :00000000 ; Heart.
    byte :01101100
    byte :11111110
    byte :11111110
    byte :11111110
    byte :01111100
    byte :00111000
    byte :00010000

lava_pattern2
    byte :00000000 ; Animated lava.
    byte :01000100
    byte :00001110
    byte :00000100
    byte :00000000
    byte :00100010
    byte :01110000
    byte :00100000

* Colors that define the characters.
character_colors
    byte >00 ; Empty.
    byte >00
    byte >00
    byte >00
    byte >00
    byte >00
    byte >00
    byte >00

    byte >f0 ; Bomb.
    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >e0
    byte >e0

    byte >e0
    byte >e0
    byte >e0
    byte >e0
    byte >e0
    byte >e0
    byte >e0
    byte >e0

    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >e0
    byte >e0

    byte >e0
    byte >e0
    byte >e0
    byte >e0
    byte >e0
    byte >e0
    byte >e0
    byte >e0

    byte >f0 ; Lit bomb.
    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >e0
    byte >e0

    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >f0
    byte >e0
    byte >e0
diamond_colors
    byte >30 ; Diamond.
    byte >20
    byte >c0
    byte >40
    byte >50
    byte >70
    byte >f0
    byte >e0

    byte >30
    byte >20
    byte >c0
    byte >40
    byte >50
    byte >70
    byte >f0
    byte >e0

    byte >32 ; Soft.
    byte >32
    byte >32
    byte >32
    byte >32
    byte >32
    byte >32
    byte >32

    byte >bc ; Lava.
    byte >bc
    byte >bc
    byte >bc
    byte >bc
    byte >bc
    byte >bc
    byte >bc

    byte >8e ; Brick.
    byte >8e
    byte >8e
    byte >8e
    byte >8e
    byte >8e
    byte >8e
    byte >8e

    byte >60 ; Rock.
    byte >60
    byte >60
    byte >60
    byte >6a
    byte >6a
    byte >6a
    byte >6a

    byte >6a
    byte >6a
    byte >6a
    byte >6a
    byte >60
    byte >60
    byte >60
    byte >60

    byte >60
    byte >60
    byte >60
    byte >60
    byte >6a
    byte >6a
    byte >6a
    byte >6a

    byte >6a
    byte >6a
    byte >6a
    byte >6a
    byte >60
    byte >60
    byte >60
    byte >60

    byte >2e ; Concrete.
    byte >3e
    byte >8e
    byte >7e
    byte >3e
    byte >2e
    byte >7e
    byte >9e

    byte >68 ; Solid.
    byte >68
    byte >68
    byte >68
    byte >68
    byte >68
    byte >68
    byte >68

    byte >70 ; Dust.
    byte >70
    byte >70
    byte >70
    byte >70
    byte >70
    byte >70
    byte >70

    byte >70
    byte >70
    byte >70
    byte >70
    byte >70
    byte >70
    byte >70
    byte >70

    byte >f0 ; Monster.
    byte >f0
    byte >b0
    byte >a0
    byte >90
    byte >90
    byte >90
    byte >80

    byte >80
    byte >60
    byte >60
    byte >d0
    byte >d0
    byte >f0
    byte >f0
    byte >f0

    byte >f0 ; Plain butterfly.
    byte >70
    byte >50
    byte >d0
    byte >d0
    byte >d0
    byte >d9
    byte >d9

    byte >d9
    byte >d9
    byte >64
    byte >d0
    byte >d0
    byte >50
    byte >70
    byte >f0

    byte >70 ; Diamonad butterfly.
    byte >50
    byte >40
    byte >40
    byte >43
    byte >42
    byte >4c
    byte >44

    byte >45
    byte >47
    byte >4f
    byte >4e
    byte >40
    byte >40
    byte >50
    byte >70

    byte >50 ; Player front.
    byte >50
    byte >f6
    byte >f6
    byte >f6
    byte >96
    byte >96
    byte >9f

    byte >94
    byte >9f
    byte >40
    byte >f0
    byte >40
    byte >f0
    byte >80
    byte >80

    byte >94 ; Legs front walking.
    byte >9f
    byte >40
    byte >f0
    byte >80
    byte >80
    byte >80
    byte >80

    byte >94
    byte >9f
    byte >40
    byte >f0
    byte >40
    byte >f0
    byte >80
    byte >80

    byte >50 ; Player right.
    byte >50
    byte >60
    byte >60
    byte >69
    byte >69
    byte >69
    byte >f0

    byte >40
    byte >f0
    byte >40
    byte >f0
    byte >40
    byte >f0
    byte >80
    byte >80

    byte >50
    byte >50
    byte >90
    byte >90
    byte >90
    byte >90
    byte >90
    byte >90

    byte >90
    byte >f0
    byte >40
    byte >f0
    byte >40
    byte >f0
    byte >80
    byte >80

    byte >40 ; Legs right walking.
    byte >f0
    byte >40
    byte >f0
    byte >40
    byte >f0
    byte >80
    byte >80

    byte >90
    byte >f0
    byte >40
    byte >f0
    byte >40
    byte >f0
    byte >80
    byte >80

    byte >50 ; Face blinking.
    byte >50
    byte >96
    byte >96
    byte >96
    byte >96
    byte >96
    byte >9f

    byte >40 ; Font vertical bar.
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40

    byte >40 ; Font top left rounded.
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40

    byte >40 ; Font center left rounded.
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40

    byte >40 ; Font bottom left rounded.
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40
    byte >40

    byte >00 ; Heart.
    byte >90
    byte >90
    byte >90
    byte >90
    byte >90
    byte >90
    byte >90
