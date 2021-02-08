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
* Sound/speech/animation-related functions: play sounds synchronously, queue
* sounds and specch and play them asynchronously, cycle colors and patterns.
******************************************************************************

* Function: play a specified sequence of sounds, waiting for it to finish.
* IN data: the address of the sound data.
play_sounds
    data sound_workspace
    data !

!   mov  *r14+, r0             ; Get the sound sequence address.
    clr  r2                    ; Get the duration.
    movb *r0+, r2

play_sounds_loop
    movb *r0+, r1              ; Get the sound data, if any.
    jeq  play_sounds_loop_exit

write_sound_data_loop
    movb r1, @sound
    movb *r0+, r1
    jne  write_sound_data_loop

    mov  r2, r1                ; Busy-wait for the duration of the sound.
sound_wait_loop
    dec  r1
    jne  sound_wait_loop

    jmp  play_sounds_loop      ; Continue with the next sound.

play_sounds_loop_exit
    li   r0, >9f00             ; Silence generator 1.
    movb r0, @sound
    rtwp

* Snippet: read the status of the speach synthesizer.
*          The snuppt has to be copied to the scratch pad to keep the
*          memory bus free,
* OUT r0: the speech status.
read_speech_status_snippet
    movb @spchrd, r0
    nop
    nop
    nop
    rt
read_speech_status_snippet_word_length equ 6

* Subroutine: read the status of the speach synthesizer.
* OUT r0: the speech status.
read_speech_status equ fast_code

* Function: initialize the speech synthesizer, and the animation,
*           speech, and sound queues.
* STATIC r6:  the diamond color index (0-7).
* STATIC r7:  the pointer to the lava pattern.
* STATIC r8:  the pointer to the queued speech data.
* STATIC r9:  the pointer to the queued sound data 1.
* STATIC r10: the pointer to the queued sound data 2.
initialize_animation_speech_sound
    data sound_workspace
    data !

!   li   r0, read_speech_status_snippet ; Copy the speech code snippet
    li   r1, read_speech_status         ; to the scratch pad.
    li   r2, read_speech_status_snippet_word_length
copy_speech_code_snippet_loop
    mov  *r0+, *r1+
    dec  r2
    jne  copy_speech_code_snippet_loop

    clr  r0                    ; Reset the speech synthesizer.
    bl   @write_speech_data
    li   r0, >1000
    movb r0, @spchwt
    nop
    nop
    bl   @read_speech_status   ; Read the speech status to r0.
    clr  r8                    ; Clear the speech queue.
    ci   r0, >aa00             ; Do we have a speech synthesizer?
    jne  no_speech_synthesizer
    li   r8, first_try_phrase  ; Initialize the speech queue.
no_speech_synthesizer
    li   r9, silence           ; Set an empty sound queue 1.
    li   r10, silence          ; Set an empty sound queue 2.

    li   r6, >0003             ; Initialize the diamond color index.
    li   r7, lava_pattern1     ; Initialize the lava pattern address.
    rtwp

* Function: queue a random speech phrase.
* IN     data: the random speech definition address.
* STATIC r6:   the rnadom seed.
* STATIC r8:   the pointer to the queued speech data.
queue_random_speech
    data sound_workspace
    data !

!   mov  *r14+, r0             ; Get the random speech definition address.
    mov  r8, r2                ; Do we have a speech synthesizer?
    jeq  dont_speak
    a    r6, r2                ; Pick a random speech definition.
    div  *r0+, r1
    c    *r0+, r2              ; Is it within the range of speech definitions?
    jle  dont_speak
    sla  r2, 1
    a    r2, r0
    mov  *r0, r8               ; Set the playing speech definition.
dont_speak
    rtwp

* Function: queue the specified sounds, if they have a higher priority than the
*           playing sounds.
* IN     data: the sound definition address.
* STATIC r9:   the pointer to the queued sound data 1.
queue_sound
    data sound_workspace
    data !

!   mov  *r14+, r0             ; Get the sound definition address.
    movb *r9, r1               ; Isn't there any sound playing?
    jeq  do_queue_sound
    c    r0, r9                ; Does the new sound have a higher priority?
    jhe  dont_queue_sound
do_queue_sound
    mov  r0, r9                ; Set the playing sound definition.
dont_queue_sound
    rtwp

* Function: update animation, speech, and sound from their queues.
* STATIC r6:  the diamond color index (0-7).
* STATIC r7:  the pointer to the lava pattern.
* STATIC r8:  the pointer to the queued speech data.
* STATIC r9:  the pointer to the queued sound data 1.
* STATIC r10: the pointer to the queued sound data 2.
update_animation_speech_sound
    data sound_workspace
    data !
update_speech_sound
    data sound_workspace
    data !!

!   inc  r6                    ; Shift the diamond colors.
    andi r6, >0007
    li   r0, >4000 | >2038     ; Update the diamond colors.
    .vdpwa r0
    mov  r6, r1
    ai   r1, diamond_colors
    bl   @write_8_bytes_to_vdp
    ai   r1, -8
    bl   @write_8_bytes_to_vdp

    li   r0, >4000 | >2188
    .vdpwa r0
    ai   r1, -8
    bl   @write_8_bytes_to_vdp
    ai   r1, -8
    bl   @write_8_bytes_to_vdp

    neg  r7                    ; Toggle the lava pattern.
    ai   r7, lava_pattern1 + lava_pattern2
    li   r0, >4000 | >0050     ; Update the lava pattern.
    .vdpwa r0
    mov  r7, r1
    bl   @write_8_bytes_to_vdp
* Continue with speech

!   mov  r8, r8                ; Do we have a speech synthesizer?
    jeq  update_sound
    mov  *r8, r0               ; Do we have speech data queued?
    jeq  update_sound
    bl   @read_speech_status   ; Is the speech synthesizer ready?
    li   r1, >8000
    coc  r1, r0
    jeq  update_sound
    mov  *r8+, r0              ; Write the speech data to the speech synthesizer.
    bl   @write_speech_data
    li   r0, >5000             ; End the speech data.
    movb r0, @spchwt
* Continue with sound

update_sound
    movb *r9, r0               ; Do we have sound data queued in queue 1?
    jeq  no_sound_data1
    inc  r9
write_sound_data1_loop
    movb r0, @sound            ; Write them to the sound chip.
    movb *r9+, r0
    jne  write_sound_data1_loop
no_sound_data1
    movb *r10, r0              ; Do we have sound data queued in queue 2?
    jeq  no_sound_data2
    inc  r10
write_sound_data2_loop
    movb r0, @sound            ; Write them to the sound chip.
    movb *r10+, r0
    jne  write_sound_data2_loop
no_sound_data2
    rtwp

* Subroutine: write 8 bytes to VDP memory, continuing from the current
*             VDP address.
* STATIC r1: the CPU source address.
write_8_bytes_to_vdp
    movb *r1+, @vdpwd
    nop
    movb *r1+, @vdpwd
    nop
    movb *r1+, @vdpwd
    nop
    movb *r1+, @vdpwd
    nop
    movb *r1+, @vdpwd
    nop
    movb *r1+, @vdpwd
    nop
    movb *r1+, @vdpwd
    nop
    movb *r1+, @vdpwd
    rt

* Function:
* IN     r9:
* STATIC r6:  the diamond color index (0-7).
* STATIC r7:  the pointer to the lava pattern.
* STATIC r8:  the pointer to the queued speech data.
* STATIC r9:  the pointer to the queued sound data 1.
* STATIC r10: the pointer to the queued sound data 2.
play_lava_sound
    data sound_workspace
    data !

!   li   r0, >c000             ; Set a random frequency for tone 3.
    movb r0, @sound
    movb @calling_r9+1(r13), r0
    andi r0, >0300
    ai   r0, >1000
    movb r0, @sound
    li   r10, lava_sound       ; Set sound queue 2.
    rtwp

* Subroutine: write 5 nibbles to the speech synthesizer.
* IN r0: the speech data.
write_speech_data
    li   r1, >0005             ; We'll write 5 nibbles.

write_speech_data_loop
    mov  r0, r2                ; Prepare the nibble.
    sla  r2, 8
    andi r2, >0f00
    ori  r2, >4000
    movb r2, @spchwt           ; Write it.
    srl  r0, 4
    dec  r1                    ; Loop until the last one.
    jne  write_speech_data_loop

    li   r0, >000a             ; Pause in a busy waiting loop.
speech_wait_loop
    dec  r0
    jne  speech_wait_loop

    rt
