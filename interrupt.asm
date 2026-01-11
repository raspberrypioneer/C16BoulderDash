; *************************************************************************************
setup_IRQ

  sei
  lda #<interrupt_actions
  sta $0314
  lda #>interrupt_actions
  sta $0315
  cli
  rts

; *************************************************************************************
interrupt_actions

  sta irq_a
  stx irq_x
  sty irq_y

interrupt_sound
  jsr update_sounds  ;self-mod into play_theme_tune or update_sounds
  jsr read_user_input

  lda irq_a
  ldx irq_x
  ldy irq_y

  jmp $ce0e  ;hardware interrupt vector

; *************************************************************************************
;Read user input from joystick port 1 and two keyboard keys SPACE and Q
; Result is returned in key_press:
;   bit 0 = up
;   bit 1 = down
;   bit 2 = left
;   bit 3 = right
;   bit 4 = Q for quit was pressed
;   bit 5 = SPACE for pause was pressed
;   bit 6 = fire
;   bit 7 = ignore

read_user_input

  ldx #$fa  ;Latch value for port 1
redo_it
  stx _KEYBOARD_LATCH  ;Store latch value in keyboard latch register
  lda _KEYBOARD_LATCH  ;Read keyboard latch register
  stx _KEYBOARD_LATCH  ;Store latch value in keyboard latch register
  cmp _KEYBOARD_LATCH  ;Compare to previous reading
  bne redo_it  ;If not equal, do it again
  eor #255   ;bit-flip, 1 now means direction, fire etc has been selected
  sta key_press

  ;Check special keys, from https://plus4world.powweb.com/plus4encyclopedia/500012
  lda #$7f	 ;Check column 7 where SPACE and Q are located
  sta _KEYBOARD_COL_SELECT	 ;Write to column selector
  sta _KEYBOARD_LATCH	 ;Write to keyboard latch
  lda _KEYBOARD_LATCH	 ;Read answer
  and #$10	 ;Check for SPACE key
  bne try_Q_key
  lda #32    ;SPACE pressed so set bit 5 for pause
  sta key_press
  jmp save_key_press
try_Q_key
  lda _KEYBOARD_LATCH	 ;Read answer
  and #$40	 ;Check for Q key
  bne end_key_press
  lda #16    ;Q pressed so set bit 4 for quit
  sta key_press
save_key_press
  sta key_press
end_key_press
  rts

; *************************************************************************************
; Plays the short sound given in play_sound_fx (got diamond, boulder moves)
;   and plays any ambient sound if set (magic wall, amoeba sounds)
update_sounds

  lda play_sound_fx
  beq check_ambient_fx
compare_sound_fx
  cmp #0                     ;has the sound effect changed?
  beq continue_sound_fx      ;if not, continue it
  lda #0                     ;otherwise, sound effect has changed, clear the note and play the new one
  jsr note_clear
continue_sound_fx
  ldy active_sound_offset    ;is the sound effect in progress?
  bne continue_the_sound     ;if so, continue it
  ldy play_sound_fx          ;otherwise, play new sound effect
  sty compare_sound_fx+1
  jmp play_note_fx

check_ambient_fx
  lda play_ambient_sound_fx  ;is there an ambient sound effect?
  beq end_ambient_sound_fx   ;if not, end
  ldy active_sound_offset    ;is the sound effect in progress?
  bne continue_the_sound     ;if so, continue it
  ldy play_ambient_sound_fx  ;otherwise, play new sound effet

  cpy #random_sound
  bne amoeba_magic_wall_sound
  ; create some 'random' audio pitches to play while revealing/hiding the map
  lda get_next_random_byte+1  ;don't use the get_next_random_byte routine which affects the reveal/hide effect
  ora #160
  sta sound_random+3
  sta sound_random+8
  sta sound_random+13
  jmp continue_the_sound

amoeba_magic_wall_sound
  ; create some 'random' audio pitches for amoeba, magic wall ambient sound fx
  jsr get_next_random_byte
  ora #192
  sta sound_amoeba_magic_wall+3
  sta sound_amoeba_magic_wall+8
  sta sound_amoeba_magic_wall+13

continue_the_sound
  jmp play_note_fx
end_ambient_sound_fx
  rts

play_note_fx  ;Y is input into this routine, used to get the sound to play
  lda #<list_of_sounds
  sta sound_address_low
  lda #>list_of_sounds
  sta sound_address_high

  lda (sound_address_low),y
  beq note_end
  sta _VOLUME_SELECT
  iny
  lda (sound_address_low),y
  sta _VOICE_2_LOW  ;voice 2 plays noise if volume + voice-select bits 5,6 are set to 0,1
  iny
  lda (sound_address_low),y
  sta _VOICE_2_HIGH  ;voice 2 plays noise if volume + voice-select bits 5,6 are set to 0,1
  iny
  lda (sound_address_low),y
  sta _VOICE_1_LOW
  iny
  lda (sound_address_low),y
  sta _VOICE_1_HIGH
  iny
  sty active_sound_offset
  rts

ambient_note_end
  lda #no_sound
  sta play_ambient_sound_fx
  jmp note_clear

note_end
  lda #0
  sta play_sound_fx
  sta compare_sound_fx+1
note_clear
  sta _VOICE_1_LOW
  sta _VOICE_1_HIGH
  sta _VOICE_2_LOW
  sta _VOICE_2_HIGH
  sta active_sound_offset
  lda #128  ;sound off
  sta _VOLUME_SELECT
  rts

; *************************************************************************************
; Play title screen theme tune
play_theme_tune

  lda theme_note_duration
  beq play_theme_note  ;duration of last note complete, start a new one
  cmp #1
  bne end_play_theme_note
  lda #0  ;clear sound between notes
  sta _VOICE_1_LOW
  lda _VOICE_1_HIGH
  and #$fc
  sta _VOICE_1_HIGH
  sta _VOICE_2_LOW
  lda _VOICE_2_HIGH
  and #$fc
  sta _VOICE_2_HIGH
end_play_theme_note
  dec theme_note_duration
  rts

play_theme_note
  ldy active_sound_offset
  lda theme_voice_1,y  ;get the low byte note given in position y
  bne skip_theme_restart  ;zero only occurs in the end of tune data sequence
  ldy #0  ;reset note position y when tune ends (voice 1 note is zero)
  lda theme_voice_1,y
skip_theme_restart
  sta _VOICE_1_LOW  ;play tune voice 1
  lda _VOICE_1_HIGH
  and #$fc  ;mask off 2 low bits
  ora theme_voice_1+1,y  ;add voice high bits
  sta _VOICE_1_HIGH
  lda theme_voice_2,y  ;use the same note position y for voice 2
  sta _VOICE_2_LOW  ;play tune voice 2
  lda _VOICE_2_HIGH
  and #$fc  ;mask off 2 low bits
  ora theme_voice_2+1,y  ;add voice high bits
  sta _VOICE_2_HIGH
  iny  ;next note (low byte)
  iny  ;next note (high byte)
  sty active_sound_offset
  lda #18  ;reset the duration
  sta theme_note_duration
  rts

theme_note_duration
  !byte 0
