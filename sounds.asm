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

; *************************************************************************************
; title theme tune
;
theme_voice_1
  !word $02C3, $0304, $032C, $0361, $02E5, $0312, $032C, $0373, $0338, $034E, $0361, $037B, $034E, $03A2, $0358, $0396
  !word $02C3, $0361, $0258, $02E5, $029C, $0373, $02E5, $029C, $02C3, $0361, $0258, $02E5, $0338, $03B1, $0361, $0338
  !word $029C, $034E, $0224, $02C3, $0320, $03A7, $034E, $0320, $0258, $0358, $0286, $0361, $0312, $0312, $0389, $0312
  !word $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361
  !word $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $034E, $034E, $034E, $034E
  !word $0361, $03B1, $0361, $03A7, $0361, $03A2, $0361, $0396, $034E, $03A7, $034E, $03A7, $034E, $0389, $034E, $03A7
  !word $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $0361, $034E, $034E, $034E, $034E
  !word $0382, $0361, $032C, $0304, $0373, $034E, $0312, $029C, $0382, $0361, $032C, $0304, $0373, $034E, $0312, $029C

theme_voice_2
  !word $0185, $0258, $02C3, $02F5, $0137, $0286, $029C, $0312, $00E0, $00E0, $0270, $00E0, $029C, $0389, $02B0, $037B
  !word $0185, $0185, $0185, $0185, $0137, $0137, $0137, $0137, $0185, $0185, $0185, $0185, $0270, $0270, $0270, $0270
  !word $0137, $0137, $0137, $0137, $023F, $023F, $023F, $023F, $00B1, $032C, $00B1, $032C, $0049, $0049, $0185, $0185
  !word $0185, $0185, $0185, $0185, $02C3, $02C3, $0185, $0185, $0137, $0137, $0137, $0137, $029C, $029C, $0137, $0137
  !word $0185, $0382, $0185, $0389, $02C3, $0382, $0185, $0389, $0137, $0382, $0137, $0389, $029C, $0373, $0137, $037B
  !word $0185, $0185, $0185, $0396, $02C3, $02C3, $0185, $037B, $0137, $0137, $0137, $0137, $029C, $029C, $0137, $0137
  !word $0185, $0382, $0185, $0389, $02C3, $0382, $0185, $0389, $0137, $0382, $0137, $0389, $029C, $0373, $0137, $037B
  !word $0361, $032C, $0304, $02C3, $034E, $0312, $02E5, $0137, $0396, $0382, $0361, $032C, $0312, $02E5, $029C, $0137
