; *************************************************************************************
; Sound effects
;  volume + voice-select byte, noise or voice 2 word, voice1 word
;  if volume + voice-select is zero, deactivate sound fx
;
;  volume + voice-select for _VOLUME_SELECT: 
;    bits 0-3 = volume (values 0 to 15)
;    bit 4 = voice 1 on / off (1 / 0)
;    bit 5 = voice 2 on / off (1 / 0)
;    bit 6 = noise on / off (1 / 0). Uses voice 2 which must be off
;    bit 7 = sound on / off (0 / 1)
voice_1 = 16
voice_2 = 32
voice_noise = 64  ;noise on voice 2

!align 255, 0
list_of_sounds
active_sound_offset
  !byte 0

sound_fx_rockford_move
  !byte (3+voice_noise)
  !word $0373,0
  !byte (4+voice_noise)
  !word $0363,0
  !byte 0  ;terminator 0
sound_fx_rock_move
  !byte (15+voice_noise)
  !word $010d,0
  !byte (13+voice_noise)
  !word $010c,0
  !byte (11+voice_noise)
  !word $010a,0
  !byte 0  ;terminator 0
sound_fx_enter_cave
  !byte (15+voice_noise)
  !word $03ff,0
  !byte (15+voice_noise)
  !word $03ef,0
  !byte (15+voice_noise)
  !word $03df,0
  !byte 0  ;terminator 0
sound_fx_explosion
  !byte (15+voice_noise)
  !word $03ff,0
  !byte (15+voice_noise)
  !word $03ef,0
  !byte (15+voice_noise)
  !word $03df,0
  !byte (12+voice_noise)
  !word $037f,0
  !byte 0  ;terminator 0
sound_fx_got_diamond
  !byte (9+voice_1)
  !word 0,$0338
  !byte (6+voice_1)
  !word 0,$034e
  !byte (3+voice_1)
  !word 0,$0373
  !byte 0  ;terminator 0
sound_fx_diamond_move
  !byte (15+voice_1)
  !word 0,$0373
  !byte (12+voice_1)
  !word 0,$0376
  !byte (9+voice_1)
  !word 0,$0372
  !byte 0  ;terminator 0
sound_fx_got_all_diamonds
  !byte (15+voice_1)
  !word 0,$02c3
  !byte (12+voice_1)
  !word 0,$0338
  !byte (9+voice_1)
  !word 0,$036a
  !byte (6+voice_1)
  !word 0,$0373
  !byte 0  ;terminator 0
sound_fx_exit_cave
  !byte (3+voice_1)
  !word 0,$03b5
  !byte (2+voice_1)
  !word 0,$03b2
  !byte (1+voice_1)
  !word 0,$03af
  !byte 0  ;terminator 0
sound_amoeba_magic_wall
  !byte (3+voice_1)
  !word 0,$0200
  !byte (2+voice_1)
  !word 0,$0200
  !byte (1+voice_1)
  !word 0,$0200
  !byte 0  ;terminator 0
sound_random
  !byte (8+voice_1)
  !word 0,$0300
  !byte (7+voice_1)
  !word 0,$0300
  !byte (6+voice_1)
  !word 0,$0300
  !byte 0  ;terminator 0
