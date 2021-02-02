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
* Sound definitions: sound data for background (asynchronous) sounds and
* for foreground (synchronous) sounds.
******************************************************************************

; A sound definition is a sequence of sequences of bytes:
;         ... = sound data for a single frame.
;         >00 = terminating zero for the data.
;
;         ...
;     >00 = terminating zero for the sequences.

sound_definitions
x33b4
    byte >ff ; Collected the required number of diamonds.
    byte >92
    byte >80
    byte >0a
    byte >00

    byte >80
    byte >09
    byte >00

    byte >80
    byte >0a
    byte >00

    byte >80
    byte >09
    byte >00

    byte >80
    byte >0a
    byte >00

    byte >80
    byte >09
    byte >00

    byte >9f
    byte >00
    byte >00

x33cb
    byte >ff ; Out of time.
    byte >92
    byte >89
    byte >3f
    byte >00

    byte >94
    byte >00

    byte >96
    byte >00

    byte >98
    byte >00

    byte >9a
    byte >00

    byte >9c
    byte >00

    byte >9e
    byte >00

    byte >9f
    byte >00
    byte >00

x33df
    byte >ff ; Almost out of time.
    byte >92
    byte >8c
    byte >1f
    byte >00

    byte >96
    byte >00

    byte >9a
    byte >00

    byte >9e
    byte >00

    byte >92
    byte >8b
    byte >23
    byte >00

    byte >96
    byte >00

    byte >9a
    byte >00

    byte >9e
    byte >00

    byte >92
    byte >81
    byte >28
    byte >00

    byte >96
    byte >00

    byte >9a
    byte >00

    byte >9e
    byte >00

    byte >9f
    byte >00
    byte >00

x3401
    byte >f2 ; Explosion to diamond.
    byte >e4
    byte >92
    byte >84
    byte >02
    byte >00

    byte >f6
    byte >88
    byte >02
    byte >00

    byte >fa
    byte >80
    byte >02
    byte >00

    byte >fe
    byte >96
    byte >00

    byte >ff
    byte >9a
    byte >00

    byte >9e
    byte >00

    byte >9f
    byte >00
    byte >00

x341a
    byte >9f ; Explosion to dust.
    byte >f2
    byte >e5
    byte >00

    byte >f6
    byte >00

    byte >fa
    byte >00

    byte >fe
    byte >00

x3424
    byte >ff ; Silence.
    byte >00
    byte >00

x3427
    byte >9f ; Dropping bomb.
    byte >f2
    byte >e4
    byte >00

    byte >f6
    byte >e2
    byte >00

    byte >ff
    byte >00
    byte >00

x3431
    byte >9f ; Collecting bomb.
    byte >f4
    byte >e0
    byte >00

    byte >ff
    byte >00
    byte >00

x3438
    byte >ff ; Collecting diamond.
    byte >92
    byte >8a
    byte >0a
    byte >00

    byte >95
    byte >8e
    byte >0b
    byte >00

    byte >9f
    byte >00
    byte >00

x3444
    byte >9f ; Pushing a rock.
    byte >f6
    byte >e5
    byte >00

    byte >ff
    byte >00
    byte >00

x344b
    byte >9f ; Landing object.
    byte >f4
    byte >e6
    byte >00

    byte >f8
    byte >00

    byte >fc
    byte >00

    byte >ff
    byte >00
    byte >00

lava_sound_definition
    byte >de
    byte >00
    byte >dc
    byte >00
    byte >df
    byte >00
    byte >00

; A sound sequence is a sequence of sequences of bytes:
;         byte = duration.
;         ...  = sound data to be played for the given duration.
;         >00 = terminating zero for the data.
;
;         ...
;     >00 = terminating zero for the sequences.

sound_sequences
x345d
    byte >08
    byte >94
    byte >80
    byte >0a
    byte >00

    byte >88
    byte >0a
    byte >00
    byte >00

x3466
    byte >08
    byte >94
    byte >80
    byte >0b
    byte >00

    byte >88
    byte >0b
    byte >00
    byte >00

x346f
    byte >08
    byte >92
    byte >80
    byte >0c
    byte >00

    byte >94
    byte >88
    byte >0c
    byte >00

    byte >96
    byte >80
    byte >0d
    byte >00

    byte >98
    byte >88
    byte >0d
    byte >00

    byte >9a
    byte >80
    byte >0e
    byte >00

    byte >9c
    byte >88
    byte >0e
    byte >00

    byte >9e
    byte >80
    byte >0f
    byte >00
    byte >00

x348d
    byte >0c
    byte >ff
    byte >df
    byte >92
    byte >80
    byte >06
    byte >00

    byte >98
    byte >00

    byte >9e
    byte >00
    byte >00

x3499
    byte >10
    byte >90
    byte >80
    byte >10
    byte >00

    byte >91
    byte >80
    byte >11
    byte >00

    byte >92
    byte >80
    byte >12
    byte >00

    byte >93
    byte >80
    byte >13
    byte >00

    byte >94
    byte >80
    byte >14
    byte >00

    byte >95
    byte >80
    byte >15
    byte >00

    byte >96
    byte >80
    byte >16
    byte >00

    byte >97
    byte >80
    byte >17
    byte >00

    byte >98
    byte >80
    byte >18
    byte >00

    byte >99
    byte >80
    byte >19
    byte >00

    byte >9a
    byte >80
    byte >1a
    byte >00

    byte >9b
    byte >80
    byte >1b
    byte >00

    byte >9c
    byte >80
    byte >1c
    byte >00

    byte >9d
    byte >80
    byte >1d
    byte >00

    byte >9e
    byte >80
    byte >1e
    byte >00

    byte >9f
    byte >00

    byte >f0
    byte >e4
    byte >00

    byte >f4
    byte >00

    byte >f8
    byte >00

    byte >fc
    byte >00

    byte >ff
    byte >00
    byte >00

x34e4
    byte >10
    byte >90
    byte >8c
    byte >1f
    byte >00

    byte >91
    byte >00

    byte >93
    byte >00

    byte >94
    byte >00

    byte >95
    byte >00

    byte >96
    byte >00

    byte >97
    byte >00

    byte >98
    byte >00

    byte >99
    byte >00

    byte >9a
    byte >00

    byte >9b
    byte >00

    byte >9c
    byte >00

    byte >9d
    byte >00

    byte >9e
    byte >00
    byte >00

x3504
    byte >06
    byte >94
    byte >80
    byte >03
    byte >00
    byte >00

x350a
    byte >10
    byte >fe
    byte >e6
    byte >00

    byte >fd
    byte >00

    byte >fc
    byte >00

    byte >fb
    byte >00

    byte >fa
    byte >00

    byte >f8
    byte >00

    byte >f6
    byte >00

    byte >f4
    byte >00

    byte >f2
    byte >00

    byte >f0
    byte >00

    byte >ff
    byte >00
    byte >00
