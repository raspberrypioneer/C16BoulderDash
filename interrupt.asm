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

;TODO: add sounds
;  jsr update_sounds  ;self-mod into play_theme_tune or update_sounds
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
  stx $ff08  ;Store latch value in joystick latch register
  lda $ff08  ;Read joystick latch register
  stx $ff08  ;Store latch value in joystick latch register
  cmp $ff08  ;Compare to previous reading
  bne redo_it  ;If not equal, do it again
  eor #255   ;bit-flip, 1 now means direction, fire etc has been selected
  sta key_press

  ;Check special keys, from https://plus4world.powweb.com/plus4encyclopedia/500012
  lda #$7f	 ;Check column 7 where SPACE and Q are located
  sta $fd30	 ;Write to keyboard latch
  sta $ff08	 ;Write to joystick latch
  lda $ff08	 ;Read answer
  and #$10	 ;Check for SPACE key
  bne try_Q_key
  lda #32    ;SPACE pressed so set bit 5 for pause
  sta key_press
  jmp save_key_press
try_Q_key
  lda $ff08	 ;Read answer
  and #$40	 ;Check for Q key
  bne end_key_press
  lda #16    ;Q pressed so set bit 4 for quit
  sta key_press
save_key_press
  sta key_press
end_key_press
  rts
