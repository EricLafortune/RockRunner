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

start_phrases
    data >0004 ; Start.
    data >0003
    data start_phrase_1
    data start_phrase_2
    data start_phrase_3

not_moving_phrases
    data >000a ; Player not moving for some time.
    data >0007
    data not_moving_phrase_1
    data not_moving_phrase_2
    data not_moving_phrase_3
    data not_moving_phrase_4
    data not_moving_phrase_5
    data not_moving_phrase_6
    data not_moving_phrase_7

almost_out_of_time_phrases
    data >0001 ; Almost out of time.
    data >0001
    data almost_out_of_time_phrase_1

out_of_time_phrases
    data >0002 ; Out of time.
    data >0002
    data out_of_time_phrase_1
    data out_of_time_phrase_2

collected_diamonds_phrases
    data >0004 ; Collected the required number of diamonds.
    data >0004
    data collected_diamonds_phrase_1
    data collected_diamonds_phrase_2
    data collected_diamonds_phrase_3
    data collected_diamonds_phrase_4

died_phrases
    data >000d ; Died.
    data >000d
    data died_phrase_1
    data died_phrase_2
    data died_phrase_3
    data died_phrase_4
    data died_phrase_5
    data died_phrase_6
    data died_phrase_7
    data died_phrase_8
    data died_phrase_9
    data died_phrase_10
    data died_phrase_11
    data died_phrase_12
    data died_phrase_13

; A speech phrase definition is a sequence of words:
;     ...   = speech phrase data.
;     >0000 = terminating zero for the data.

first_try_phrase
    data >2bd7
    data >6fbb
    data >0000

start_phrase_1
    data >2ffc
    data >0000

start_phrase_2
    data >637c
    data >0000

start_phrase_3
    data >56b3
    data >0000

not_moving_phrase_1
    data >351a
    data >0000

not_moving_phrase_2
    data >1e54
    data >4c41
    data >0000

not_moving_phrase_3
    data >2ffc
    data >4c41
    data >0000

not_moving_phrase_4
    data >46df
    data >4c41
    data >0000

not_moving_phrase_5
    data >78f4
    data >76b0
    data >0000

not_moving_phrase_6
    data >77bc
    data >4ada
    data >0000

not_moving_phrase_7
    data >71be
    data >556e
    data >6489
    data >4fe5
    data >0000

almost_out_of_time_phrase_1
    data >5093
    data >3757
    data >0000

out_of_time_phrase_1
    data >7e4d
    data >6e69
    data >3a32
    data >739f
    data >0000

out_of_time_phrase_2
    data >3c4f
    data >6e69
    data >3e78
    data >0000

collected_diamonds_phrase_1
    data >30fa
    data >0000

collected_diamonds_phrase_2
    data >7717
    data >253e
    data >0000

collected_diamonds_phrase_3
    data >5bfb
    data >1fcd
    data >0000

collected_diamonds_phrase_4
    data >4959
    data >5bfb
    data >0000

died_phrase_1
    data >71f4
    data >0000

died_phrase_2
    data >61c6
    data >0000

died_phrase_3
    data >3571
    data >0000

died_phrase_4
    data >3148
    data >0000

died_phrase_5
    data >49a5
    data >0000

died_phrase_6
    data >700f
    data >0000

died_phrase_7
    data >77e9
    data >0000

died_phrase_8
    data >4b7d
    data >3c4f
    data >0000

died_phrase_9
    data >4642
    data >4642
    data >0000

died_phrase_10
    data >78ab
    data >556e
    data >71be
    data >0000

died_phrase_11
    data >3793
    data >3f2f
    data >67b6
    data >0000

died_phrase_12
    data >1c48
    data >1c48
    data >4ee0
    data >0000

died_phrase_13
    data >71be
    data >775c
    data >360a
