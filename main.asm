; *************************************************************************************
; Boulder Dash for the C16
; by raspberrypioneer Dec 2025
;

_SCREEN_ADDR = $c00  ;3072 screen address
_COLOUR_SCREEN_ADDR = $800  ;2048 colour screen address

_BACKGROUND_COLOUR_ADDR = $ff15  ;65301 background colour
_COLOUR_REGISTER_1_ADDR = $ff16  ;65302 colour register 1
_COLOUR_REGISTER_2_ADDR = $ff17  ;65303 colour register 2
_COLOUR_REGISTER_3_ADDR = $ff18  ;65304 colour register 3
_BORDER_COLOUR_ADDR = $ff19  ;65305 border colour

_VOICE_1_LOW = $ff0e  ;65294 voice 1 frequency low byte
_VOICE_1_HIGH = $ff12  ;65298 voice 1 frequency high 2 bits 0,1
_VOICE_2_LOW = $ff0f  ;65295 voice 2 frequency low byte
_VOICE_2_HIGH = $ff10  ;65296 voice 2 frequency high 2 bits 0,1
_VOLUME_SELECT = $ff11  ;65297 volume bits 0-3; voice 1,2,noise on/off bits 4-6; sound off/on bit 7

_KEYBOARD_LATCH = $ff08  ;65288 keyboard / joystick latch
_KEYBOARD_COL_SELECT = $fd30  ;64816 keyboard column selector

_CLEAR_SCREEN = $c567  ;ROM: SCNCLR, clear screen
_KERNAL_SETLFS = $ffba  ;Kernal: SETLFS, set logical first and second addresses
_KERNAL_SETNAM = $ffbd  ;Kernal: SETNAM, set filename
_KERNAL_LOADSP = $ffd5  ;Kernal: LOAD, load into memory from device

_CHARACTER_BASE_ADDR = $ff13  ;65299 character data base address bits 2-7
_TED_ROM_RAM_SELECT = $ff12  ;65298 TED data fetch ROM/RAM select bit 2
_MULTICOLOUR_MODE = $ff07  ;65287 multicolor mode bit 4 on/off, hardware reverse characters bit 7 off/on

;map elements defines
map_space=0
map_earth=1
map_wall=2
map_titanium_wall=3
map_diamond=4
map_rock=5
map_firefly=6
map_amoeba=7
map_rockford_appearing_or_end_position=8
map_slime=9
map_explosion=10
map_bomb=11
map_growing_wall=12
map_magic_wall=13
map_butterfly=14
map_rockford=15

;animation states
map_anim_state0=0
map_anim_state1=16
map_anim_state2=32
map_anim_state3=48
map_anim_state4=64
map_anim_state5=80
map_anim_state6=96
map_anim_state7=112

;special map states
map_active_exit=24
map_start_large_explosion=70
map_large_explosion_state1=19
map_large_explosion_state2=35
map_large_explosion_state3=51
map_unprocessed=128
map_deadly=192

;sprite defines
sprite_space=0
sprite_boulder1=1
sprite_boulder2=2
sprite_diamond1=3
sprite_diamond2=4
sprite_diamond3=5
sprite_diamond4=6
sprite_titanium_wall1=7
sprite_titanium_wall2=8
sprite_box=9
sprite_wall1=10
sprite_wall2=11
sprite_explosion1=12
sprite_explosion2=13
sprite_explosion3=14
sprite_explosion4=15
sprite_magic_wall1=16
sprite_magic_wall2=17
sprite_magic_wall3=18
sprite_magic_wall4=19
sprite_amoeba1=20
sprite_amoeba2=21
sprite_butterfly1=22
sprite_butterfly2=23
sprite_butterfly3=24
sprite_firefly1=25
sprite_firefly2=26
sprite_firefly3=27
sprite_firefly4=28
sprite_earth1=29
sprite_earth2=30
sprite_pathway=31
sprite_rockford_blinking1=32
sprite_rockford_blinking2=33
sprite_rockford_blinking3=34
sprite_rockford_winking1=35
sprite_rockford_winking2=36
sprite_rockford_tapping_foot1=37
sprite_rockford_tapping_foot2=38
sprite_rockford_tapping_foot3=39
sprite_rockford_tapping_foot4=40
sprite_rockford_tapping_foot5=41
sprite_rockford_moving_left1=42
sprite_rockford_moving_left2=43
sprite_rockford_moving_left3=44
sprite_rockford_moving_left4=45
sprite_rockford_moving_right1=46
sprite_rockford_moving_right2=47
sprite_rockford_moving_right3=48
sprite_rockford_moving_right4=49
sprite_bomb1=50
sprite_bomb2=51
sprite_bomb3=52
sprite_bomb4=53
sprite_bubble=54
sprite_anti_space=55

;keys
KEY_MASK_UP=1
KEY_MASK_DOWN=2
KEY_MASK_LEFT=4
KEY_MASK_RIGHT=8
KEY_MASK_ESCAPE=16
KEY_MASK_PAUSE=32
KEY_MASK_FIRE=64

;status_messages
message_none=0
message_clear=16
message_paused=32
message_got_all_diamonds=48
message_no_bombs_left=64
message_hurry_up=80
message_out_of_time=96
message_bonus_life=112
message_game_over=128
message_loading=144

;sounds
no_sound=0
rockford_move_sound=1
rock_move_sound=12
enter_cave_sound=28
explosion_sound=44
got_diamond_sound=65
diamond_move_sound=81
hurry_sound=81;  ;same as diamond_move_sound
got_all_diamonds_sound=97
bonus_life_sound=97  ;same as got_all_diamonds_sound
exit_cave_sound=118
magic_wall_sound=134
growing_wall_sound=134  ;same as magic_wall_sound
amoeba_sound=134  ;same as magic_wall_sound
random_sound=150

; *************************************************************************************
zero_page_start
neighbour_cell_directions = $10  ;used as a table for the cell variables below
cell_above_left = $10
cell_above = $11
cell_above_right = $12
cell_left = $13
cell_current = $14
cell_right = $15
cell_below_left = $16
cell_below = $17
cell_below_right = $18

neighbour_cell_pointer = $19

key_press = $1a

irq_a = $2a
irq_x = $2b
irq_y = $2c

sprite_address_low = $23
sprite_address_high = $24

sound_address_low = $25
sound_address_high = $26

screen_addr1_low = $40
screen_addr1_high = $41
screen_addr2_low = $42
screen_addr2_high = $43

colour_addr1_low = $44
colour_addr1_high = $45
colour_addr2_low = $46
colour_addr2_high = $47

map_address_low = $21
map_address_high = $22

map_cols = $0b
map_rows = $0c

map_rockford_current_position_addr_low = $48
map_rockford_current_position_addr_high = $49

map_rockford_end_position_addr_low = $50
map_rockford_end_position_addr_high = $51

visible_top_left_map_x = $54
visible_top_left_map_y = $55

score_low = $0d
score_high = $0e

temp1 = $72
temp2 = $73

player_lives = $56
cave_number = $57
difficulty_level = $58
diamonds_required = $59
time_remaining = $5a
bomb_counter = $5b
bomb_delay = $5c
gravity_timer = $5d
magic_wall_state = $5e
magic_wall_timer = $5f
amoeba_growth_interval = $60
amoeba_counter = $61
amoeba_replacement = $62
number_of_amoeba_cells_found = $63
bonus_timer = $64
rockford_cell_value = $65
current_rockford_sprite = $66
rockford_explosion_cell_type = $67
current_amoeba_cell_type = $68
neighbour_cell_contents = $69
delay_trying_to_push_rock = $6a
saved_message = $6b
message_timer = $6c

tick_counter = $6d
sub_second_ticks = $6e
ticks_since_last_direction_key_pressed = $6f
play_sound_fx = $70
play_ambient_sound_fx = $71

; *************************************************************************************
* = $fff
  !byte $01,$10  ;for PRG load start
  !byte $0b,$10,$0a,$00,$9e,$34,$31,$30,$39,$00,$00,$00
;Note                   sys   4   1   0   9         is sys 4109 i.e. $100d

; *************************************************************************************

  ;set the location of custom characters and font
  ;The graphic chip character base address is set to 8192 ($2000)
  ;poke 65299, (peek(65299) and 3) or 32
  lda _CHARACTER_BASE_ADDR
  and #3
  ora #32
  sta _CHARACTER_BASE_ADDR

  ;The graphic chip reads character patterns from RAM
  ;poke 65298, peek(65298) and 251
  lda _TED_ROM_RAM_SELECT
  and #251  ;point to RAM
  sta _TED_ROM_RAM_SELECT

  ;Set multi-colour mode and expand the redefined character range to 256 characters
  ;poke 65287, peek(65287) or (16+128)
  lda _MULTICOLOUR_MODE  ;ff07
  ora #16  ;multi-colour mode
  ora #128  ;expand the character set to 256 separate patterns by turning off the reverse setting
  sta _MULTICOLOUR_MODE

; *************************************************************************************
; Select version to play

  jsr _CLEAR_SCREEN
  lda #0  ;Black
  sta _BACKGROUND_COLOUR_ADDR
  sta _BORDER_COLOUR_ADDR

  jsr select_caves_for_version  ;Let the user select the game version to play

; *************************************************************************************
; Menu to start with and return to after a game ends
menu_loop
  jsr intro_and_cave_select

  lda #3
  sta player_lives

  lda #0
  sta score_low
  sta score_high
  sta bonus_low
  sta bonus_high

  ;game loop for each of the player lives
play_next_life
  jsr play_one_life
  lda player_lives
  bne play_next_life

  jmp menu_loop

; ****************************************************************************************************
; Let the user select which version of Boulder Dash to play and load the caves file for it
select_caves_for_version

br_start_pos = (5 * 40) + 2  ;big rockford position: 5 lines x 40 columns + centre
op_start_pos = (16 * 40) + 12  ;versions start position: 16 lines x 40 columns + centre

  ;Display big Rockford and instructions
  lda #<big_rockford_instructions
  sta screen_addr1_low  ;source low
  lda #>big_rockford_instructions
  sta screen_addr1_high  ;source high

  lda #<_SCREEN_ADDR+40
  sta screen_addr2_low  ;target low
  lda #>_SCREEN_ADDR+40
  sta screen_addr2_high  ;target high

  ;size is 560 bytes for display (16 lines of 40 columns)
  lda #$80
  sta copy_size  
  lda #$02
  sta copy_size+1

  jsr copy_memory

  ;set text colour
  lda #113  ;white bright
  ldx #161
set_instruction_text_colour
  dex
  sta _COLOUR_SCREEN_ADDR,x
  sta _COLOUR_SCREEN_ADDR+160,x
  sta _COLOUR_SCREEN_ADDR+320,x
  sta _COLOUR_SCREEN_ADDR+480,x
  bne set_instruction_text_colour

  ;draw rockford with diamond
  ldy #0
big_rockford_draw
  lda #122  ;bright, off-white shade
  sta _COLOUR_SCREEN_ADDR+br_start_pos,y
  sta _COLOUR_SCREEN_ADDR+40+br_start_pos,y
  sta _COLOUR_SCREEN_ADDR+80+br_start_pos,y
  sta _COLOUR_SCREEN_ADDR+120+br_start_pos,y
  sta _COLOUR_SCREEN_ADDR+160+br_start_pos,y
  sta _COLOUR_SCREEN_ADDR+200+br_start_pos,y
  sta _COLOUR_SCREEN_ADDR+240+br_start_pos,y

  lda #83 ;cyan medium brightness
  sta _COLOUR_SCREEN_ADDR+52,y
  sta _COLOUR_SCREEN_ADDR+52+8,y

  lda #82 ;red medium brightness
  sta _COLOUR_SCREEN_ADDR+op_start_pos,y
  sta _COLOUR_SCREEN_ADDR+op_start_pos+8,y

  iny
  cpy #8
  bne big_rockford_draw

  jsr setup_IRQ  ;setup joystick-keyboard actions interrupt

  ;version selection
  lda version_selected
version_display
  jsr show_version_text

version_selection_delay
  lda #20
  sta temp1
  ldx #$ff
  jsr delay_a_bit_longer
  lda #4
  sta version_selection_delay+1

version_loop
  lda key_press

  cmp #KEY_MASK_RIGHT
  beq version_down

  cmp #KEY_MASK_LEFT
  beq version_up

  cmp #KEY_MASK_UP
  beq version_up

  cmp #KEY_MASK_DOWN
  beq version_down

  cmp #KEY_MASK_FIRE
  beq end_version_selection

  jmp version_loop

end_version_selection

  lda version_selected  ;multiply by 4 (2 x asl)
  asl
  asl
  tay
  ldx #0
set_cave_name
  lda cave_version_prefix,y
  sta name_of_cave,x
  iny
  inx
  cpx #4
  bne set_cave_name

  ldy #0
loading_message_loop
  lda status_message_loading,y
  sta _SCREEN_ADDR+op_start_pos,y
  iny
  cpy #16
  bne loading_message_loop
  rts

version_down
  ldy version_selected
  lda version_selection_cycle_down,y
  sta version_selected
  jmp version_display

version_up
  ldy version_selected
  lda version_selection_cycle_up,y
  sta version_selected
  jmp version_display

version_selected
  !byte 0

show_version_text
  ldx #0  ;data position counter
  ldy #0  ;screen position counter (ok for 6 options)

  lda #0  ;versions line counter
  sta temp1
version_lines_loop
  lda #113  ;white bright
  sta set_version_line_colour+1  ;self-mod
  lda temp1
  cmp version_selected
  bne draw_version_line
  lda #83 ;cyan medium brightness
  sta set_version_line_colour+1  ;self-mod

draw_version_line
  jsr draw_version_char_line  ;version line
  inc temp1
  lda temp1
  cmp #6
  bne version_lines_loop
  rts

draw_version_char_line
  lda version_choices_text,x
  beq end_version_char_line
  sta _SCREEN_ADDR+op_start_pos+80,y
set_version_line_colour
  lda #82  ;red medium brightness (initial colour, changed with self-mod)
  sta _COLOUR_SCREEN_ADDR+op_start_pos+80,y
  inx
  iny
  bne draw_version_char_line
end_version_char_line
  inx  ;count past the end of line character
  tya
  clc
  adc #25  ;Add 25 to screen position for each line (doesn't exceed 255)
  tay
  rts

; *************************************************************************************
; Load and display the intro screen, accept the cave, level, keyset from the user and start the game
intro_and_cave_select

  lda #25  ;Cave Z (intro cave)
  sta cave_number

  ;set-up cave and variables
  jsr load_cave_for_version
  jsr initialise_variables
  jsr _CLEAR_SCREEN
  jsr populate_cave_from_loaded_data

  ;set visible map and Rockford position for drawing grid
  lda #0
  sta visible_top_left_map_x
  sta visible_top_left_map_y
  jsr set_rockford_start

  ;set start of map
  lda #<tile_map_row_1
  sta map_address_low
  lda #>tile_map_row_1
  sta map_address_high
  jsr draw_borders
  jsr set_cave_colours

  ;set the tile check logic in draw grid (self-mod code)
  ldx #0
  jsr self_mod_code
  lda #skip_null_tile-(skip_tile_check+4)  ;branch forward to skip_null_tile (+4 bytes for cmp,#,beq,#)
  sta skip_tile_check+3

  ;knock-out Rockford and growing wall handlers for now
  ;growing wall is ignored on the intro screen, so that the title text isn't removed when drawing the map
  lda #<handler_null
  sta rockford_handler_low
  sta growing_wall_handler_low
  lda #>handler_null
  sta rockford_handler_high
  sta growing_wall_handler_high

  ;initialise sound variables and switch interrupt sound actions to the theme tune
  jsr note_end

  lda #15  ;set volume to max
  ora #48  ;turn on voices 1,2
  sta _VOLUME_SELECT

  lda #<play_theme_tune
  sta interrupt_sound+1
  lda #>play_theme_tune
  sta interrupt_sound+2

  ;set title text
  jsr set_title_text

  ;Tick counter needed for some animation
  lda #31
  sta tick_counter

  ;cave number and levels to start selection from
  lda #0
  sta cave_number

  lda #1
  sta difficulty_level

  ;set options text
  ldy #40
show_options_loop
  dey
  lda #113  ;text etc, white
  sta _COLOUR_SCREEN_ADDR,y

  lda game_options,y
  sta _SCREEN_ADDR,y
  cpy #0
  bne show_options_loop

  ;exception colours
  lda #82  ;cave and level, medium red
  sta _COLOUR_SCREEN_ADDR+13
  sta _COLOUR_SCREEN_ADDR+23

  ;draw map, waiting for user input
wait_for_keypress
  jsr update_map
  jsr draw_grid_of_sprites
  dec tick_counter

  lda key_press
  cmp #KEY_MASK_FIRE
  beq exit_intro_keypress

  cmp #KEY_MASK_UP
  beq level_up

  cmp #KEY_MASK_LEFT
  beq cave_down

  cmp #KEY_MASK_DOWN
  beq level_down

  cmp #KEY_MASK_RIGHT
  beq cave_up

  jmp wait_for_keypress

exit_intro_keypress

  ;switch interrupt sound actions back to normal for gameplay
  jsr note_end

  lda #0
  sta play_ambient_sound_fx

  lda #<update_sounds
  sta interrupt_sound+1
  lda #>update_sounds
  sta interrupt_sound+2

  ;nop out the tile check logic in draw grid (self-mod code)
  ldx #12
  jsr self_mod_code

  ;add back Rockford and growing wall handlers
  lda #<handler_rockford
  sta rockford_handler_low
  lda #>handler_rockford
  sta rockford_handler_high
  lda #<handler_growing_wall
  sta growing_wall_handler_low
  lda #>handler_growing_wall
  sta growing_wall_handler_high

  rts

cave_down
  ldy cave_number
  lda cave_selection_cycle_down,y
  sta cave_number
  jmp cave_display

cave_up
  ldy cave_number
  lda cave_selection_cycle_up,y
  sta cave_number
  jmp cave_display

cave_display
  ldy cave_number
  iny  ;start of screen codes for letters
  sty _SCREEN_ADDR+13
  jmp wait_for_keypress

level_down
  ldy difficulty_level
  lda level_selection_cycle_down,y
  sta difficulty_level
  jmp level_display

level_up
  ldy difficulty_level
  lda level_selection_cycle_up,y
  sta difficulty_level
  jmp level_display

level_display
  clc
  adc #48  ;start of screen codes for numbers
  sta _SCREEN_ADDR+23
  jmp wait_for_keypress

handler_null
  rts

; *************************************************************************************
; Set menu screen title text
set_title_text

  ldy #12
game_title_loop
  dey
  lda game_title,y
  sta _SCREEN_ADDR+574,y
  lda #113  ;text etc, white
  sta _COLOUR_SCREEN_ADDR+574,y
  cpy #0
  bne game_title_loop
  rts

; *************************************************************************************
; Game action starts here, playing one of Rockford's lives
play_one_life

  ;cave letter and difficulty level on status bar
  ldy cave_number
  iny
  sty status_bar_line+38
  lda difficulty_level
  clc
  adc #48
  sta status_bar_line+39
  jsr setup_status_bar

  ;set-up cave and variables
  ldy #message_loading
  jsr update_status_bar
  jsr load_cave_for_version
  jsr initialise_variables
  jsr populate_cave_from_loaded_data
  jsr populate_cave_tiles_pseudo_random

  ;set start of map
  lda #<tile_map_row_1
  sta map_address_low
  lda #>tile_map_row_1
  sta map_address_high

  jsr set_cave_colours
  jsr draw_borders
  jsr initialise_stage

  ;dissolve screen when starting
  jsr prepare_reveal_hide_code
  lda #map_space
  jsr screen_dissolve_effect

  ;for normal game play, nop out the logic applied above in draw grid (self-mod code)
  ldx #12
  jsr self_mod_code

  jsr update_cave_time
  jsr update_player_score
  ldy #message_none
  sty saved_message
  jsr update_status_bar

  jsr gameplay_loop

  ;check for game over
  lda player_lives
  bne not_game_over

  ldy #message_game_over
  jsr update_status_bar

not_game_over

  ;un-dissolve screen when ending
  jsr prepare_reveal_hide_code
  lda #map_unprocessed
  jsr screen_dissolve_effect
  rts

; *************************************************************************************
initialise_variables
  
  lda #$9f
  sta rockford_cell_value
  lda #240
  sta ticks_since_last_direction_key_pressed
  lda #31
  sta tick_counter
  lda #12
  sta sub_second_ticks
  lda #4
  sta delay_trying_to_push_rock
  lda #map_magic_wall
  sta magic_wall_state
  sta amoeba_growth_interval
  lda #1
  sta amoeba_counter
  lda #0
  sta message_timer
  sta amoeba_replacement
  sta number_of_amoeba_cells_found
  sta current_rockford_sprite
  sta rockford_explosion_cell_type
  sta bonus_timer
  sta cell_type_to_sprite  ;ensure space is the first sprite in table
  sta play_sound_fx
  sta play_ambient_sound_fx
  sta theme_note_duration
  rts

; *************************************************************************************
; Routine to self-mod a section of code, used to replace code in draw_grid_of_sprites
; for displaying text in the map and to reveal-hide tiles
self_mod_code

  ldy #0
self_mod_code_loop
  lda self_mod_code_table,x
  inx
  sta skip_tile_check,y
  iny
  cpy #6
  bne self_mod_code_loop
  rts

; *************************************************************************************
; Self-mod code applied to draw_grid_of_sprites routine to reveal-hide tiles used in cave open/close
prepare_reveal_hide_code
  ;add a check for unprocessed cells and set to titanium tile in draw grid (self-mod code)
  ldx #6
  jsr self_mod_code
  lda #not_titanium-(skip_tile_check+4)  ;branch forward to not_titanium (+4 bytes for cmp,#,bcc,#)
  sta skip_tile_check+3
  rts

; *************************************************************************************
; Apply the cave open/close tiles which show/hide the tiles on screen
; Performed in a loop using the game tick counter
screen_dissolve_effect
  sta dissolve_to_solid_flag

; use 'random' audio pitches to play while revealing/hiding the map
  lda #random_sound
  sta play_ambient_sound_fx

  lda #33
  sta tick_counter
screen_dissolve_loop
  jsr reveal_or_hide_more_cells
  jsr draw_grid_of_sprites
  dec tick_counter
  bpl screen_dissolve_loop

  jsr ambient_note_end
  rts

dissolve_to_solid_flag
  !byte 0

; *************************************************************************************
; Apply the tile show/hide routine for each game play tick
reveal_or_hide_more_cells
  ldy #<tile_map_row_0
  sty map_address_low
  lda #>tile_map_row_0
  sta map_address_high

  ldx #22
loop_over_rows
  lda map_address_low
  ; rows are stored in the first 40 bytes of every 64 bytes, so skip if we have
  ; exceeded the right range
  and #63
  cmp #40
  bpl skip_to_next_row
  ; progress a counter in a non-obvious pattern
  jsr get_next_random_byte
  ; if it's early in the process (tick counter is low), then branch more often so we
  ; reveal/hide the cells in a non-obvious pattern over time
  lsr
  lsr
  lsr
  cmp tick_counter
  bne skip_reveal_or_hide
  lda (map_address_low),y
  ; clear the top bit to reveal the cell...
  and #$7f
  ; ...or set the top bit to hide the cell
  ora dissolve_to_solid_flag
  sta (map_address_low),y
skip_reveal_or_hide
  inc map_address_low
  bne skip_increment
  inc map_address_high
skip_increment
  clc
  bcc loop_over_rows
  ; move forward to next row. Each row is stored at 64 byte intervals. We have moved
  ; on 40 so far so add the remainder to get to the next row
skip_to_next_row
  lda #64-40
  jsr add_a_to_ptr
  dex
  bne loop_over_rows
  rts

; *************************************************************************************
; A small 'pseudo-random' number routine. Generates a sequence of 256 numbers.
get_next_random_byte
  lda #0
  asl
  asl
  asl
  asl
  sec
  adc get_next_random_byte+1
  sta get_next_random_byte+1
  rts

; *************************************************************************************
; Loop over all rows, plotting side borders from the cave file
draw_borders

  ldx #21
write_left_and_right_borders_loop
  ldy #38
cells_to_processed_loop
  lda (map_address_low),y
  ora #map_unprocessed
  sta (map_address_low),y
  dey
  bne cells_to_processed_loop
  lda #$40
  jsr add_a_to_ptr
  dex
  bne write_left_and_right_borders_loop

; write the top and bottom borders using param_border_tile (steelwall if zero)
  lda param_border_tile
  ldx #39
write_top_and_bottom_borders_loop
  sta tile_map_row_0,x
  sta tile_map_row_21,x
  dex
  bpl write_top_and_bottom_borders_loop
  rts

; *************************************************************************************
; Apply the cave colours from the parameters, affects border, foreground colour and auxiliary colour
;   Note: Black = 0, White = 1, Red = 2, Cyan = 3, Purple = 4, Green = 5, Blue = 6, Yellow = 7, Orange = 8,
;   Brown = 9, YellowGreen = 10, Pink = 11, BlueGreen = 12, LightBlue = 13, DarkBlue = 14, LightGreen = 15
set_cave_colours

  lda param_colours  ;Group 1 for most of titanium walls, rocks, amoeba; part of rockford, diamonds
  ora #80  ;medium brightness
  sta _COLOUR_REGISTER_1_ADDR

  lda param_colours+1  ;Group 2 earth
  ora #80  ;medium brightness
  sta _COLOUR_REGISTER_2_ADDR

  ;ignore third colour parameter, param_colours+2 for group 3 most of walls, rockford; part of rocks, diamonds
  lda #122  ;bright, off-white shade
  sta _COLOUR_REGISTER_3_ADDR
  sta foreground_colourA+1
  sta foreground_colourB+1

  rts

; *************************************************************************************
; Apply the parameters for the cave being played
initialise_stage

  lda #20
  sta visible_top_left_map_x
  lsr
  sta visible_top_left_map_y

  ; set the delay between amoeba growth
  lda param_amoeba_magic_wall_time
  sta amoeba_growth_interval
  sta magic_wall_timer

  ; set the gravity timer
  ldy #0
  lda param_zero_gravity_time
  beq dont_allow_rock_push_up
  ldy #$ee  ;Special value used to detect rock has been pushed up, only applies when gravity is off
dont_allow_rock_push_up
  sta gravity_timer
  sty rock_push_directions+2

  ; initialise random seed for possible use with slime permeability
  lda #0
  sta random_seed2

  ; put the end tile on the map
  lda param_rockford_end
  sta map_rows
  lda param_rockford_end+1
  sta map_cols
  jsr map_xy_position_to_map_address
  ldy #0
  lda #map_titanium_wall
  sta (map_address_low),y
  lda map_address_low
  sta map_rockford_end_position_addr_low
  lda map_address_high
  sta map_rockford_end_position_addr_high

  ; put the start tile on the map
  jsr set_rockford_start

  ;set cave parameters
  ldx difficulty_level
  dex
  lda param_diamonds_required,x
  sta diamonds_required
  lda param_cave_time,x
  sta time_remaining

  ;show or hide the bombs character depending on use in the cave
  lda param_bombs
  sta bomb_counter
  beq clear_bomb_on_status_bar
  lda #245
  sta status_bar_line+28
  jmp update_status_bar_from_params
clear_bomb_on_status_bar
  lda #32
  sta status_bar_line+28
update_status_bar_from_params

  ;update diamonds required, bombs available, player lives on status bar
  jsr update_diamonds_required
  jsr update_bombs_available
  jsr update_player_lives

  rts

; *************************************************************************************
; Plays the cave, each iteration of the loop is a game play tick
; The loop ends when Rockford's completes the cave or loses a life
gameplay_loop

  lda #0
  sta current_amoeba_cell_type
  sta neighbour_cell_contents

  ; reset number of amoeba cells found, and if already zero then clear the amoeba_replacement
  ldx #0
  lda number_of_amoeba_cells_found
  stx number_of_amoeba_cells_found
  bne skip_clearing_amoeba_replacement
  stx amoeba_replacement
skip_clearing_amoeba_replacement
  stx current_amoeba_cell_type

  jsr update_map
  jsr update_cave_time
  ldy #message_none

  ;update status message
  lda message_timer  ;check if a message should be displayed
  beq show_message_update
  dec message_timer
  ldy saved_message
  lda message_timer
  and #4  ;every 4 ticks, clear message then switch back to saved message
  bne show_message_update
  cpy #message_hurry_up
  bne skip_hurry_sound
  lda #hurry_sound
  sta play_sound_fx
skip_hurry_sound

  ldy #message_clear
show_message_update
  jsr update_status_bar

  ; get the contents of the cell that rockford is influencing. This can be the cell
  ; underneath rockford, or by holding the RETURN key down and pressing a direction
  ; key it can be one of the neighbouring cells.
  ; We clear the top bits to just extract the basic type.
  lda neighbour_cell_contents
  and #$0f
  sta neighbour_cell_contents
  cmp #map_rockford_appearing_or_end_position
  bne rockford_is_not_at_end_position
  jmp update_with_gameplay_not_active  ;Rockford is at the end position (rts from this jmp returns to jsr gameplay_loop)

rockford_is_not_at_end_position
  jsr draw_grid_of_sprites
  jsr update_amoeba_timing

  ; check if the player is still alive by reading the current rockford sprite (branch if not)
  lda current_rockford_sprite
  beq check_for_earth
  ; update game timer (sub seconds)
  dec sub_second_ticks
  bpl check_for_earth
  ; each 'second' of game time has 11 game ticks
  ldx #11
  stx sub_second_ticks
  ; decrement time remaining ('seconds') on the status bar
  dec time_remaining
  ; branch if there's still time left
  bne check_for_earth
  ; out of time
  ldy #message_out_of_time
  jsr update_status_bar
  jsr update_with_gameplay_not_active
  jmp lose_a_life

check_for_earth
  lda time_remaining
  cmp #10
  beq hurry_up
  jmp check_for_earth2
hurry_up
  lda #hurry_sound
  sta play_sound_fx
  lda #message_hurry_up
  sta saved_message
  lda #103
  sta message_timer
check_for_earth2
  lda neighbour_cell_contents
  cmp #map_earth
  bne skip_earth

  ldx play_sound_fx
  cpx #rockford_move_sound
  bcc keep_current_sound1  ;don't override a sound effect with Rockford default movement sound
  stx play_sound_fx
keep_current_sound1

skip_earth
  cmp #map_diamond
  bne skip_got_diamond

  ldx #got_diamond_sound
  stx play_sound_fx

  jsr got_diamond_so_update_status_bar
  jsr update_diamonds_required
  jsr update_player_score

skip_got_diamond
  ; update game tick
  dec tick_counter
  lda tick_counter
  and #7
  bne update_death_explosion
  ;update bomb delay timer
  lda bomb_delay
  beq end_update_bomb_delay
  dec bomb_delay
end_update_bomb_delay
  ; update gravity timer
  lda gravity_timer
  beq end_update_gravity_timer  ;stop at zero
  cmp #$ff
  beq end_update_gravity_timer  ;gravity is always on if set to #$ff
  dec gravity_timer
  bne end_update_gravity_timer
  lda #0
  sta rock_push_directions+2
end_update_gravity_timer
  ; update magic wall timer
  lda magic_wall_state
  cmp #map_magic_wall | map_anim_state1  ;active
  bne update_death_explosion
  dec magic_wall_timer
update_death_explosion
  ldx rockford_explosion_cell_type
  beq check_for_escape_key_pressed_to_die
  inx
  stx rockford_explosion_cell_type
  cpx #$4b
  bmi check_for_escape_key_pressed_to_die
  ; if key is pressed at end of the death explosion sequence, then reduce player lives and exit
  lda key_press
  bne lose_a_life
  dec rockford_explosion_cell_type
  ; branch if escape not pressed
check_for_escape_key_pressed_to_die
  lda key_press
  and #KEY_MASK_ESCAPE
  beq check_if_pause_is_available
  ; branch if explosion already underway
  lda rockford_explosion_cell_type
  bne check_if_pause_is_available
  ; start death explosion
  lda #map_start_large_explosion
  sta rockford_explosion_cell_type
  ; branch if on a bonus stage (no pause available)
check_if_pause_is_available
  lda cave_number
  cmp #16
  bpl gameplay_loop_local
  ; check if pause pressed
  jsr check_for_pause_key
  beq gameplay_loop_local
  jsr update_with_gameplay_not_active
gameplay_loop_local
  jmp gameplay_loop

lose_a_life
  jsr note_clear
  lda cave_number
  cmp #16  ;don't lose a life on a bonus cave, just move to next cave instead
  bcs unsuccessful_bonus_cave
  dec player_lives
  jsr update_player_lives
  ldy #message_none
  jsr update_status_bar
  rts
unsuccessful_bonus_cave
  jsr calculate_next_cave_number_and_level
  rts

; *************************************************************************************
; Update screen while paused, or out of time, or at end position
;   (i.e. when gameplay started but is not currently active)
update_with_gameplay_not_active

  ; check for pause key
  jsr check_for_pause_key
  beq check_if_end_position_reached
  ; pause mode, show pause message
  lda #0
  sta pause_counter
update_while_initially_pressing_pause_loop
  jsr check_for_pause_key
  bne update_while_initially_pressing_pause_loop
pause_loop
  inc pause_counter
  ldy #message_paused
  ; toggle between showing pause and clear message every 16 ticks
  lda pause_counter
  and #$10
  beq skip_showing_players_and_men
  ldy #message_clear
skip_showing_players_and_men
  jsr update_during_pause_or_out_of_time
  beq pause_loop
update_while_finally_pressing_unpause_loop
  jsr check_for_pause_key
  bne update_while_finally_pressing_unpause_loop
  lda #message_none
  sta saved_message
  rts

pause_counter
  !byte 0

check_if_end_position_reached
  lda neighbour_cell_contents
  ; check if end position has been reached
  cmp #map_rockford_appearing_or_end_position
  beq rockford_reached_end_position
  ; show out of time message for a while, then return
  lda #$3e
  sta out_of_time_message_countdown
  ldy #message_out_of_time
out_of_time_loop
  jsr update_during_pause_or_out_of_time
  bne gameplay_not_active_return
  dec out_of_time_message_countdown
  bne out_of_time_loop
  rts

out_of_time_message_countdown
  !byte 0

  ; clear rockford's final position, and set rockford on end position
rockford_reached_end_position
  ldy #0
  lda (map_rockford_current_position_addr_low),y
  and #$7f
  tax
  tya
  sta (map_rockford_current_position_addr_low),y
  txa
  sta (map_rockford_end_position_addr_low),y

  lda cave_number
  cmp #15  ; award a life if the end was reached on a bonus cave
  bcc not_a_bonus_end
  inc player_lives
  jsr update_player_lives

  ;update message bar
  lda #message_bonus_life
  sta saved_message
  lda #39
  sta message_timer

not_a_bonus_end
  jsr draw_grid_of_sprites
  lda time_remaining
  beq skip_bonus

  lda #exit_cave_sound
  sta play_ambient_sound_fx
count_up_bonus_at_end_of_stage_loop

  ;countdown the remaining time and add to score
  dec time_remaining
  jsr update_cave_time

  ;add 1 to score for each time unit left
  lda #1
  jsr update_score
  jsr update_player_score
  ldy #message_none
  jsr update_status_bar

  jsr draw_grid_of_sprites

  lda time_remaining
  bne count_up_bonus_at_end_of_stage_loop
skip_bonus
  jsr ambient_note_end

  ;Determine next cave and level to play
  jsr calculate_next_cave_number_and_level
  ldy #message_none

update_during_pause_or_out_of_time
  sty save_message_number
  jsr update_status_bar
  jsr draw_grid_of_sprites
  ldy save_message_number
  jsr check_for_pause_key
gameplay_not_active_return
  rts

save_message_number
  !byte 0

; *************************************************************************************
check_for_pause_key

  lda key_press
  and #KEY_MASK_PAUSE
  rts

; *************************************************************************************
; Apply updates to diamonds required, score, sound etc when a diamond is gathered
; Includes check if all diamonds have been gathered and opens the exit
got_diamond_so_update_status_bar

  lda diamonds_required
  bne update_diamonds_required_and_check_got_all

  ;already got all the diamonds, so just update score with their extra value
  lda param_diamond_extra_value
  jsr update_score
  jmp got_diamond_return

update_diamonds_required_and_check_got_all

  lda param_diamond_value  ;update score with diamond value
  jsr update_score

  dec diamonds_required  ;subtract 1 from diamonds needed
  bne got_diamond_return

  ; got all the diamonds
  lda #message_got_all_diamonds
  sta saved_message
  lda #39
  sta message_timer

  ; open the exit
  ldy #0
  lda #map_active_exit
  sta (map_rockford_end_position_addr_low),y

  ; flash path (spaces)
  lda #sprite_anti_space
  sta cell_type_to_sprite
  jsr draw_grid_of_sprites
  lda #sprite_space
  sta cell_type_to_sprite

  lda #got_all_diamonds_sound
  sta play_sound_fx
got_diamond_return
  rts

; *************************************************************************************
; Populate game tile map from cave_map_data loaded from file
populate_cave_from_loaded_data

  lda #>cave_map_data                ; Point to cave address high byte
  sta plot_cave_tiles_x2+2           ; Store in self-modifying code location
  lda #<cave_map_data                ; Point to cave address low byte
  sta plot_cave_tiles_x2+1           ; Store in self-modifying code location

  lda #$14                           ; Set row counter to 20 (excluding steel top and bottom rows)
  sta load_row_counter
  lda #<tile_map_row_1               ; Point to start of map (low)
  sta map_address_low
  lda #>tile_map_row_1               ; Point to start of map (high)
  sta map_address_high

load_plot_cave_row
  ldy #$00                           ; Set column start to 0
plot_cave_tiles_x2
  lda cave_map_data                  ; The cave_map_data value after LDA is changed in this routine (self-modifying code)
  pha                                ; Store the byte (equates to 2 tiles) on the stack
  lsr                                ; left shift bits x 4 to get the nibble
  lsr
  lsr
  lsr
  sta (map_address_low),y            ; Store nibble as tile value to map
  iny                                ; Add 1 for next tile position
  pla                                ; Pull the byte off the stack
  and #$0f                           ; Get the second nibble
  sta (map_address_low),y            ; Store nibble as tile value to map
  iny                                ; Add 1 for next tile position
  inc plot_cave_tiles_x2+1           ; Move onto the next byte, calculating the high bytes as well
  lda plot_cave_tiles_x2+1
  bne load_skip_inc_high_byte
  inc plot_cave_tiles_x2+2
load_skip_inc_high_byte
  cpy #$28                           ; Check if 40 tiles plotted
  bne plot_cave_tiles_x2             ; Continue if not
  lda #$40                           ; Add 64 to map_address_low
  jsr add_a_to_ptr
  dec load_row_counter               ; Decrease row counter by 1
  lda load_row_counter
  beq populate_cave_return           ; If no more rows (counter is zero), go to end of routine
  jmp load_plot_cave_row             ; Continue to plot the next cave row

populate_cave_return
  rts

load_row_counter
  !byte 0

; *************************************************************************************
add_a_to_ptr

  clc
  adc map_address_low
  sta map_address_low
  bcc add_ptr_return
  inc map_address_high
add_ptr_return
  rts

; ****************************************************************************************************
delay_a_bit_longer

delay_long
  jsr delay_a_bit
  dec temp1
  bne delay_long
  rts

; ****************************************************************************************************
delay_a_bit
delay1
  ldy $ff
delay2
  dey
  bne delay2
  dex
  bne delay1
  rts

; *************************************************************************************
; Map address (which starts at $3000) becomes row/column in map_rows/cols
; e.g. $3000 is 0,0   $3098 is 2,24   $3140 is 5,0   $310f is 5,15
map_address_to_map_xy_position

  lda map_address_high
  and #7
  sta map_rows
  lda map_address_low
  asl
  rol map_rows
  asl
  rol map_rows
  lda map_address_low
  and #$3f
  sta map_cols
  rts

; *************************************************************************************
; Convert a grid position (row/column) to a map address
map_xy_position_to_map_address

  lda #0
  sta map_address_low
  lda map_rows
  lsr
  ror map_address_low
  lsr
  ror map_address_low
  ora #>tile_map_row_0
  sta map_address_high
  lda map_cols
  ora map_address_low
  sta map_address_low
  rts

; *************************************************************************************
; screen addresses, also used for colour addresses (high byte is calculated)
;
char_screen_high
  !byte $0c, $0c, $0c, $0d, $0d, $0d, $0e, $0e, $0e, $0e, $0f, $0f
char_screen_low
  !byte $28, $78, $c8, $18, $68, $b8, $08, $58, $a8, $f8, $48, $98
char_screen_below_high
  !byte $0c, $0c, $0c, $0d, $0d, $0d, $0e, $0e, $0e, $0f, $0f, $0f
char_screen_below_low
  !byte $50, $a0, $f0, $40, $90, $e0, $30, $80, $d0, $20, $70, $c0

; *************************************************************************************
; Draw a full grid of sprites, updating the current map position first
; IMPORTANT: this table must not go-over a page boundary
!align 255, 0

draw_grid_of_sprites

  jsr update_map_scroll_position
  jsr update_grid_animations

  lda #0  ;skip status bar
  sta map_rows  ;grid row counter
loop_plot_row
  tay

  lda char_screen_low,y
  sta screen_addr1_low
  lda char_screen_high,y
  sta screen_addr1_high

  lda char_screen_below_low,y
  sta screen_addr2_low
  lda char_screen_below_high,y
  sta screen_addr2_high

  lda char_screen_low,y
  sta colour_addr1_low  ;colour low values are the same as screen low values
  lda char_screen_high,y
  and #$0b  ;use char screen high to calculate colour high values e.g. $0c -> $08 etc
  sta colour_addr1_high

  lda char_screen_below_low,y
  sta colour_addr2_low  ;colour low values are the same as screen low values
  lda char_screen_below_high,y
  and #$0b  ;use char screen high to calculate colour high values e.g. $0c -> $08 etc
  sta colour_addr2_high

  lda #0
  sta map_cols  ;grid column counter
loop_plot_column

  ;Get sprite number from map
  tay
  lda (map_address_low),y

  ;Next 6 bytes are changed with self-mod code
skip_tile_check
  cmp #map_growing_wall
  beq skip_null_tile
  nop
  nop
not_titanium

  tay
  lda cell_type_to_sprite,y
  tay

  ;Lookup sprite high/low address in the sprite list table
  lda sprite_addresses_low,y
  sta sprite_address_low
  lda sprite_addresses_high,y
  sta sprite_address_high

  ;Transfer the 4 bytes which make up the sprite tile to the locations below (self-mod code)
  ldy #0
  lda (sprite_address_low),y
  sta top_left_char+1
  iny
  lda (sprite_address_low),y
  sta top_right_char+1
  iny
  lda (sprite_address_low),y
  sta bottom_left_char+1
  iny
  lda (sprite_address_low),y
  sta bottom_right_char+1

  ;Plot the top 2 and bottom 2 characters for the tile
  lda map_cols  ;grid column counter
  asl  ;Double the counter number to get the screen offset position
  tay
top_left_char
  lda #65
  sta (screen_addr1_low),y
bottom_left_char
  lda #67
  sta (screen_addr2_low),y

foreground_colourA
  lda #14  ;blue
  sta (colour_addr1_low),y
  sta (colour_addr2_low),y

  iny

top_right_char
  lda #66
  sta (screen_addr1_low),y
bottom_right_char
  lda #68
  sta (screen_addr2_low),y

foreground_colourB
  lda #14  ;blue
  sta (colour_addr1_low),y
  sta (colour_addr2_low),y

skip_null_tile
  inc map_cols  ;grid column counter
  lda map_cols  ;grid column counter
  cmp #20  ;20 columns
  bcc loop_plot_column
  lda #$40  ; move tile pointer on to next row (64 bytes)
  jsr add_a_to_ptr
  inc map_rows  ;grid row counter
  lda map_rows  ;grid row counter
  cmp #12  ;12 rows (skip status bar in rows 0, 1)
  bcs end_draw
  jmp loop_plot_row

end_draw
  rts

; *************************************************************************************
; Animation works by checking 14 animation sequences
;   cell_types_that_always_animate returns an element map / map-animated value (e.g. map_anim_state1 | map_firefly)
;   cell_type_to_sprite takes this value and looks up its sprite value (e.g. sprite_firefly4)
;   sprite_to_next_sprite takes the sprite value and looks up the replacement sprite (e.g. sprite_firefly1)
;   cell_type_to_sprite is updated with the replacement, so next time the lookup returns sprite_firefly1
;     which then points to sprite_firefly2 and so on
update_grid_animations

  ldx #$0e
  stx temp1
update_sprites_to_use_loop
  ldy cell_types_that_always_animate,x
  ldx cell_type_to_sprite,y
  ; look up the next sprite in the animation sequence
  lda sprite_to_next_sprite,x
  sta cell_type_to_sprite,y
  dec temp1
  ldx temp1
  bpl update_sprites_to_use_loop

  ;Animate for bonus life
  lda bonus_timer  ;check if bonus animation applies
  beq skip_bonus_animation
  dec bonus_timer
  ldy #sprite_pathway
  lda bonus_timer
  and #4  ;every 4 ticks, switch from pathway to space sprite
  bne show_bonus_animation
  ldy #sprite_space
show_bonus_animation
  sty cell_type_to_sprite
skip_bonus_animation

  ; use the tick counter (bottom two bits scaled up by 16) to update amoeba animation (and apply to slime as well)
  lda tick_counter
  and #3
  asl
  asl
  asl
  asl
  tax
  lda amoeba_animated_sprite0,x
  eor #1
  sta amoeba_animated_sprite0,x
  sta slime_animated_sprite0,x
  lda amoeba_animated_sprite4,x
  eor #1
  sta amoeba_animated_sprite4,x
  sta slime_animated_sprite1,x

  ; animate exit
  lda exit_cell_type
  eor #$10
  sta exit_cell_type

  ; update rockford idle animation
  lda ticks_since_last_direction_key_pressed
  tay
  and #$3f
  tax
  lda idle_animation_data,x
  ; check for nearing the end of the idle animation (range $c0-$ff).
  ; Use the top nybbles of the data if so.
  cpy #$c0
  bcc extract_lower_nybble
  ; Near the end of the idle animation. Shift the upper nybble into the bottom nybble
  ; to get more idle sprites
  lsr
  lsr
  lsr
  lsr
extract_lower_nybble
  and #$0f
  ; set the rockford sprite
  ora #sprite_rockford_blinking1
  sta rockford_sprite
  inc ticks_since_last_direction_key_pressed
  rts

; *************************************************************************************
; Set Rockford start position (row/column) on map
set_rockford_start

  lda param_rockford_start
  sta map_rows
  lda param_rockford_start+1
  sta map_cols
  jsr map_xy_position_to_map_address
  ldy #0
  lda #map_rockford_appearing_or_end_position
  sta (map_address_low),y
  lda map_address_low
  sta map_rockford_current_position_addr_low
  lda map_address_high
  sta map_rockford_current_position_addr_high
  rts

; *************************************************************************************
; Scrolls the map by setting the map_address_high/low and visible_top_left_map_x and y
; Note: each time Rockford moves and pushes the boundaries, visible_top_left_map_x and y are incremented / decremented
;       this means the visible position is not set based on Rockford's absolute position at the start
update_map_scroll_position

  lda map_rockford_current_position_addr_low
  sta map_address_low
  lda map_rockford_current_position_addr_high
  sta map_address_high
  jsr map_address_to_map_xy_position  ;determine Rockford's row and column position on map, returned in map_rows/cols
  sec
  sbc visible_top_left_map_x  ;subtract visible top left x from calculated column position, result in A
  ldx visible_top_left_map_x
  cmp #16  ;how many tiles are visible on the left, going right
  bmi check_for_need_to_scroll_left
  cpx #20  ;how many tiles are visible on the left, going right to stop going right
  bpl check_for_need_to_scroll_down
  inx
check_for_need_to_scroll_left
  cmp #4  ;how many tiles are visible on the left, going left
  bpl check_for_need_to_scroll_down
  cpx #1  ;how many tiles are visible on the left, going left to stop going left
  bmi check_for_need_to_scroll_down
  dex
check_for_need_to_scroll_down
  ldy visible_top_left_map_y
  lda map_rows
  sec
  sbc visible_top_left_map_y
  cmp #8  ;how many tiles are visible above, going down
  bmi check_for_need_to_scroll_up
  cpy #10  ;how many tiles are visible above, going down to stop going down
  bpl check_for_bonus_stages
  iny
check_for_need_to_scroll_up
  cmp #4  ;how many tiles are visible above, going up
  bpl check_for_bonus_stages
  cpy #1  ;how many tiles are visible above, going up to stop going up
  bmi check_for_bonus_stages
  dey
check_for_bonus_stages
  lda param_intermission
  beq skip_bonus_stage
  lda #0  ; bonus stage window position is fixed
  tax
  tay
skip_bonus_stage
  stx visible_top_left_map_x
  stx map_cols
  sty visible_top_left_map_y
  sty map_rows
  jsr map_xy_position_to_map_address
  rts

; *************************************************************************************
; Update the gameplay map with action handlers for each of the game actors
; Includes logic for falling rocks, diamonds, bombs
update_map

  ; Slow it down a bit
  ldx #$af
  jsr delay_a_bit

  lda #20  ; twenty rows
  sta map_rows
  lda #>tile_map_row_0
  sta map_address_high
  lda #<tile_map_row_0
  sta map_address_low
  ; Each row is stored in the first 40 bytes of every 64 bytes. Here we set Y to
  ; start on the second row, after the titanium wall border
  ldy #$40
  ; loop through the twenty rows of map
tile_map_y_loop
  lda #38  ; 38 columns (cells per row)
  sta map_cols
  lda (map_address_low),y
  sta cell_left
  ; move to the next cell
  iny
  ; read current cell contents into X
  lda (map_address_low),y
  tax
  ; loop through the 38 cells in a row of map
  ; read next cell contents into cell_right
tile_map_x_loop
  ldy #$42
  lda (map_address_low),y
  sta cell_right
  ;Below checks if space, earth, wall, steel wall and just marks as processed, no handlers needed
  cpx #map_diamond
  bmi mark_cell_above_as_processed_and_move_to_next_cell

  ; read cells into cell_above and cell_below variables
  ldy #1
  lda (map_address_low),y
  sta cell_above
  ldy #$81
  lda (map_address_low),y
  sta cell_below

  ; if current cell is already processed (top bit set), then skip to next cell
  txa
  bmi mark_cell_above_as_processed_and_move_to_next_cell
  ; mark current cell as processed (set top bit)
  ora #$80
  tax
  ; the lower four bits are the type, each of which has a handler to process it
  and #$0f
  tay
  lda handler_table_high,y
  ; if we have no handler for this cell type then branch (destination was set
  ; depending on where we entered this routine)
  beq update_rock_or_diamond_that_can_fall
  sta handler_high
  lda handler_table_low,y
  sta handler_low
  ; call the handler for the cell based on the type (0-15)
jsr_handler_instruction
handler_low = jsr_handler_instruction+1
handler_high = jsr_handler_instruction+2
  jsr handler_rockford

  ; the handler may have changed the surrounding cells, store the new cell below
  lda cell_below
  ldy #$81
  sta (map_address_low),y
  ; store the new cell above
  lda cell_above
  and #$7f
  ldy #1
  bpl move_to_next_cell  ; ALWAYS branch

; *************************************************************************************
mark_cell_above_as_processed_and_move_to_next_cell

  ldy #1
  lda (map_address_low),y
  and #$7f
move_to_next_cell
  sta (map_address_low),y
  ; store the new cell left back into the map
  lda cell_left
  ldy #$40
  sta (map_address_low),y
  ; update cell_left with the current cell value (in X)
  stx cell_left
  ; update the current cell value x from the cell_right variable
  ldx cell_right
  ; move ptr to next position
  inc map_address_low
  ; loop back for the rest of the cells in the row
  dec map_cols
  bne tile_map_x_loop
  ; store the final previous_cell for the row
  lda cell_left
  sta (map_address_low),y
  ; move ptr to the start of the next row. Stride is 64, 38 entries done, so
  ; remainder to add is 64-38=26
  lda #26
  jsr add_a_to_ptr
  ; loop back for the rest of the rows
  dec map_rows
  bne tile_map_y_loop
  ; clear top bit in final row
  ldy #38
clear_top_bit_on_final_row_loop
  lda tile_map_row_20,y
  and #$7f
  sta tile_map_row_20,y
  dey
  bne clear_top_bit_on_final_row_loop
  ; clear top bit on end position
  lda (map_rockford_end_position_addr_low),y
  and #$7f
  sta (map_rockford_end_position_addr_low),y
  rts

; *************************************************************************************
; Update for rock/diamond/bomb elements
update_rock_or_diamond_that_can_fall

  cpy #map_bomb
  bne not_a_bomb
  jsr handler_bomb  ;handle the bomb timer before continuing so it behaves like a rock/diamond
not_a_bomb
  lda gravity_timer
  beq gravity_on_as_normal
  ;gravity is off, so a rock/diamond/bomb can float
  cpy #map_rock
  bne mark_cell_above_as_processed_and_move_to_next_cell  ;only want to transition the rock
  ldx #map_rock | map_unprocessed | map_anim_state1  ;switch to a bubble sprite
  lda gravity_timer
  cmp #4
  bcs mark_cell_above_as_processed_and_move_to_next_cell
  ldx #map_rock | map_unprocessed | map_anim_state2  ;switch to a bubble-transition-to-rock sprite instead
  jmp mark_cell_above_as_processed_and_move_to_next_cell  ;bypass rock/diamond/bomb falling when gravity is off
gravity_on_as_normal
  cpx #map_rock | map_unprocessed | map_anim_state2
  bne not_a_rock
  ldx #map_rock | map_unprocessed  ;switch back to rock
not_a_rock
  ldy #$81
  lda (map_address_low),y
  beq cell_below_is_a_space
  ; check current cell
  cpx #map_deadly
  bmi not_c0_or_above
  jsr process_c0_or_above
not_c0_or_above
  and #$4f
  tay
  asl
  bmi process_next_cell
  lda cell_types_that_rocks_or_diamonds_will_fall_off,y
  beq process_next_cell
  lda cell_left
  bne check_if_cell_right_is_empty
  ; cell left is empty, now check below left cell
  ldy #$80
  lda (map_address_low),y
  beq rock_or_diamond_can_fall_left_or_right
check_if_cell_right_is_empty
  lda cell_right
  bne process_next_cell
  ; cell right is empty, now check below right cell
  ldy #$82
  lda (map_address_low),y
  bne process_next_cell
  ; take the rock or diamond, and set bit 6 to indicate it has been moved this scan
  ; (so it won't be moved again). Then store it in the below left or below right cell
rock_or_diamond_can_fall_left_or_right
  txa
  ora #map_anim_state4
  sta (map_address_low),y
set_to_unprocessed_space
  ldx #$80
  bne process_next_cell  ; ALWAYS branch

  ; take the rock or diamond, and set bit 6 to indicate it has been moved this scan
  ; (so it won't be moved again). Then store it in the cell below.
cell_below_is_a_space
  txa
  ora #map_anim_state4
  sta (map_address_low),y
  bne set_to_unprocessed_space  ; ALWAYS branch

process_c0_or_above
  pha
  ; look up table based on type
  and #$0f
  tay
  lda update_cell_type_when_below_a_falling_rock_or_diamond,y
  beq play_rock_or_diamond_fall_sound
  ; store in cell below
  ldy #$81
  sta (map_address_low),y
play_rock_or_diamond_fall_sound

  ldy #rock_move_sound
  txa
  and #$0f
  cmp #map_diamond
  bne save_rock_or_diamond_fall_sound
  ldy #diamond_move_sound
save_rock_or_diamond_fall_sound
  sty play_sound_fx

  ; mask off bit 6 for the current cell value
  txa
  and #$bf
  tax
  pla
  rts

;Needed because subroutine is out of range to branch to
process_next_cell
  jmp mark_cell_above_as_processed_and_move_to_next_cell

; *************************************************************************************
; Handler for Rockford entry, converstion of amoeba into diamonds
; Called once handler_rockford_intro_or_exit sets the last transition to $21 (x is an explosion sprite)
; $21 becomes unprocessed (ora #$80) and subtracted from #$90 = $11 so not processed initially but X is set to $11, set in update_map
; $11 becomes unprocessed (ora #$80) and subtracted from #$90 = $1 and using explosion_replacements table, becomes unprocessed Rockford
handler_basics

  txa
  sec
  sbc #$90
  cmp #$10
  bpl not_in_range_so_change_nothing
  ; cell is in the range $90-$9f (corresponding to $10 to $1f with the top bit set),
  ; so we look up the replacement in a table. This is used to replace the final step
  ; of an explosion, either with rockford during the introduction (offset $01), or a
  ; space for the outro (death) explosion (offset $03)
  tax
  lda explosion_replacements,x
not_in_range_so_change_nothing
  tax
  rts

; *************************************************************************************
; Handler for Rockford's intro/exit
handler_rockford_intro_or_exit

  txa
  and #$7f
  tax
  ; branch if on exit
  cpx #map_active_exit
  beq intro_or_exit_return
  ; we have found the intro square
  ; wait for flashing rockford animation to finish
  lda tick_counter
  cmp #$f0
  bpl intro_or_exit_return
  ; start the explosion just before gameplay starts (x is an explosion sprite)
  ldx #$21
  lda #enter_cave_sound
  sta play_sound_fx

intro_or_exit_return
  rts

; *************************************************************************************
; Handler for Firefly/Butterfly actions, moving, exploding etc
; Below is needed to point the program counter to the next page (multiple of 256)
handler_firefly_or_butterfly

  cpx #map_deadly
  bpl show_large_explosion
  ; check directions in order: cell_below, cell_right, cell_left, cell_up
  ldy #8
look_for_amoeba_or_player_loop
  lda neighbour_cell_directions-1,y
  and #7
  eor #7
  beq show_large_explosion
  dey
  dey
  bne look_for_amoeba_or_player_loop
  ; calculate direction to move in Y
  txa
  lsr
  lsr
  lsr
  and #7
  tay
  ; branch if the desired direction is empty
  ldx firefly_neighbour_pointers,y
  lda neighbour_cell_directions,x
  beq set_firefly_or_butterfly
  ; get the next direction in Y
  lda firefly_and_butterfly_next_direction_table,y
  tay
  ; branch if the second desired direction is empty
  ldx firefly_neighbour_pointers,y
  lda neighbour_cell_directions,x
  beq set_firefly_or_butterfly
  ; set X=0 to force the use of the final possible direction
  ldx #0
  ; get the last cardinal direction that isn't a u-turn
  lda firefly_and_butterfly_next_direction_table,y
  tay
set_firefly_or_butterfly
  lda firefly_and_butterfly_cell_values,y
  cpx #0
  bne store_firefly_and_clear_current_cell
  tax
  rts

store_firefly_and_clear_current_cell
  sta neighbour_cell_directions,x
  ldx #0
  rts

; *************************************************************************************
; Handles the large explosion affecting 9 cells which turn into spaces or diamonds
show_large_explosion

  txa
  ldx #<cell_types_that_will_turn_into_large_explosion
  and #8
  beq set_explosion_type
  ldx #<cell_types_that_will_turn_into_diamonds
set_explosion_type
  stx lookup_table_address_low
  ; activate explosion sound
  lda #explosion_sound
  sta play_sound_fx
  ; read above left cell
  ldy #0
  lda (map_address_low),y
  sta cell_above_left
  ; reset current cell to zero
  sty cell_current
  ; read above right cell
  ldy #2
  lda (map_address_low),y
  sta cell_above_right
  ; read below left cell
  ldy #$80
  lda (map_address_low),y
  sta cell_below_left
  ; read below right cell
  ldy #$82
  lda (map_address_low),y
  sta cell_below_right
  ; loop 9 times to replace all the neighbour cells with diamonds or large explosion
  ldx #9
replace_neighbours_loop
  lda neighbour_cell_directions-1,x
  and #$0f
  tay
read_from_table_instruction
lookup_table_address_low = read_from_table_instruction+1
  lda cell_types_that_will_turn_into_large_explosion,y
  beq skip_storing_explosion_into_cell
  sta neighbour_cell_directions-1,x
skip_storing_explosion_into_cell
  dex
  bne replace_neighbours_loop
  ; write new values back into the corner cells
  ; write to above left cell
  ldy #0
  lda cell_above_left
  and #$7f
  sta (map_address_low),y
  ; write to above right cell
  ldy #2
  lda cell_above_right
  sta (map_address_low),y
  ; write to below left cell
  ldy #$80
  lda cell_below_left
  sta (map_address_low),y
  ; write to below right cell
  ldy #$82
  lda cell_below_right
  sta (map_address_low),y
  ldx cell_current
  rts

; *************************************************************************************
; Handler for growing wall which allows a wall to extend horizontally if the item beside it is empty space
handler_growing_wall

  lda cell_left                                          ; read cell to the left of the growing wall
  and #$0f                                               ; getting the cell type from the lower nybble
  bne check_grow_right                                   ; If not zero (map_space) then examine cell to the right
  lda #map_unprocessed | map_growing_wall                ; Otherwise replace the left cell with another growing wall
  sta cell_left
  lda #growing_wall_sound
  sta play_sound_fx
check_grow_right
  lda cell_right                                         ; read cell to the right of the growing wall
  and #$0f                                               ; getting the cell type from the lower nybble
  bne growing_wall_return                                ; If not zero (map_space) then end
  lda #map_unprocessed | map_growing_wall                ; Otherwise replace the right cell with another growing wall
  sta cell_right
  lda #growing_wall_sound
  sta play_sound_fx
growing_wall_return
  rts

; *************************************************************************************
; Handler for magic wall which turns rocks to diamonds (or diamonds to rocks)
; Activated when a rock/diamond falls onto it and a rock/diamond is converted if there is
; space below the magic wall, otherwise it disappears. Deactives when the magic wall timer
; ends, rocks/diamonds disappear if they fall on a deactivated magic wall
handler_magic_wall

  txa
  ldx magic_wall_state
  ;wait for something to land on the wall to continue, see update_cell_type_when_below_a_falling_rock_or_diamond
  cmp #map_unprocessed | map_anim_state3 | map_magic_wall
  bne check_if_magic_wall_is_active
  ; read what's above the wall, getting the cell type from the lower nybble
  lda cell_above
  and #$0f
  tay
  ; read what cell types are allowed to fall through and what is produced as a result
  ; (rocks turn into diamonds and vice versa)
  lda items_produced_by_the_magic_wall,y
  beq skip_storing_space_above
  ; something will fall into the wall, clear the cell above
  ldy #map_unprocessed | map_space
  sty cell_above
skip_storing_space_above
  cpx #map_magic_wall | map_anim_state2  ;inactive
  beq store_magic_wall_state
  ; if the cell below isn't empty, then don't store the item below
  ldy cell_below
  bne magic_wall_is_active
  ; store the item that has fallen through the wall below
  ora #map_anim_state4  ; mark the rock / diamond / bomb as fallen
  sta cell_below
magic_wall_is_active
  lda #magic_wall_sound
  sta play_ambient_sound_fx
  ldx #map_magic_wall | map_anim_state1  ;active
  ldy magic_wall_timer
  bne store_magic_wall_state
  ; magic wall becomes inactive once the timer has run out
  jsr ambient_note_end
  ldx #map_magic_wall | map_anim_state2  ;inactive
store_magic_wall_state
  stx magic_wall_state
  rts

check_if_magic_wall_is_active
  cpx #map_magic_wall | map_anim_state1  ;active
  beq magic_wall_is_active
  rts

; *************************************************************************************
; Handler for amoeba movement actions
handler_amoeba

  lda amoeba_replacement
  beq update_amoeba
  tax
  rts

update_amoeba
  inc number_of_amoeba_cells_found
  ; check for surrounding space or earth allowing the amoeba to grow
  lda #$0e
  bit cell_above
  beq amoeba_can_grow
  bit cell_left
  beq amoeba_can_grow
  bit cell_right
  beq amoeba_can_grow
  bit cell_below
  bne amoeba_return
amoeba_can_grow
  stx current_amoeba_cell_type
  lda #amoeba_sound
  sta play_ambient_sound_fx
  inc amoeba_counter
  lda amoeba_counter
  cmp amoeba_growth_interval
  bne amoeba_return
  lda #0
  sta amoeba_counter
  ; calculate direction to grow based on current amoeba state in top bits
  txa
  lsr
  lsr
  lsr
  and #6
  ; Y is set to 0,2,4, or 6 for the compass directions
  tay
  cpx #map_deadly
  bmi check_for_space_or_earth
  ; get cell value for direction Y
  lda cell_above,y
  beq found_space_or_earth_to_grow_into
  ; move amoeba onto next state (add 16)
increment_top_nybble_of_amoeba
  txa
  clc
  adc #$10
  and #$7f
  tax
  rts

  ; get cell value for direction Y
check_for_space_or_earth
  lda cell_above,y
  ; branch if 0 or 1 (space or earth)
  and #$0e
  bne increment_top_nybble_of_amoeba
found_space_or_earth_to_grow_into
  lda tick_counter
  lsr
  bcc store_x
  jsr increment_top_nybble_of_amoeba
store_x
  txa
  sta cell_above,y
amoeba_return
  rts

; *************************************************************************************
; Updates amoeba timing. At the end of amoeba growth time converts to diamonds if it is
; constrained and cannot grow anymore, otherwise converts to rocks
update_amoeba_timing

  lda number_of_amoeba_cells_found
  beq check_for_amoeba_timeout
  ldy current_amoeba_cell_type
  bne found_amoeba
  ldx #map_unprocessed | 18  ;via handler_basics and explosion_replacements table converts to diamond
  bne amoeba_replacement_found  ;always branch
found_amoeba
  adc #$38
  bcc check_for_amoeba_timeout
  ; towards the end of the level time the amoeba turns into rock
  ldx #map_unprocessed | map_rock
amoeba_replacement_found
  stx amoeba_replacement
  jsr ambient_note_end
check_for_amoeba_timeout
  lda time_remaining
  cmp #50
  bne amoeba_timing_return
  lda sub_second_ticks
  cmp #7
  bne amoeba_timing_return
  lda #1
  sta amoeba_growth_interval
  ; Set A=0 and zero the amoeba counter
  lsr
  sta amoeba_counter
amoeba_timing_return
  rts

; *************************************************************************************
; Handler for slime element which allows rocks and diamonds to pass through it but nothing else
; The slime permeability cave parameter controls how quickly rocks and diamonds can pass through it
handler_slime

  lda cell_above                     ; read what's above the wall, getting the cell type from the lower nybble
  and #$0f
  tay
  lda items_allowed_through_slime,y  ; read which cell types are allowed to fall through
  beq slime_return                   ; If not the right type (rock / diamond / bomb) then end
  sta item_allowed
  lda cell_below
  bne slime_return                   ; If no space below the slime for a rock / diamond / bomb to fall then end
  lda param_slime_permeability
  beq slime_pass_through             ; If slime permeability is zero, no delay in pass through
  lda #0                             ; Otherwise continue and determine random delay
  sta random_seed1
  lda random_seed2
  bne slime_delay                    ; If random_seed2 is not zero, use it for pseudo_random calculation
  lda param_slime_permeability       ; Otherwise set random_seed2 to slime permeability value
  sta random_seed2
slime_delay
  jsr pseudo_random                  ; Call pseudo-random routine returning random_seed1 in the accumulator
  cmp #$04                           ; A suitable delay-comparison value
  bcc slime_pass_through             ; If random_seed1 is less than delay-comparison value then let the item pass through
  rts                                ; Otherwise skip the item. Next time in loop, will use the last random_seed2 value and eventually pass through

slime_pass_through
  lda #map_unprocessed | map_space   ; something will fall into the wall, clear the cell above
  sta cell_above
  lda item_allowed
  ora #map_anim_state4               ; mark the rock / diamond / bomb as fallen
  sta cell_below                     ; store the item that has fallen through the wall below
slime_return
  rts

item_allowed
  !byte 0

; ****************************************************************************************************
; Pseudo-random function
;   Using a seed value, apply various operations to provide a value in random_seed1 used above
;   This value is not random, for a given seed value, the returned value is always predictable
; ****************************************************************************************************
pseudo_random

  lda random_seed1
  ror
  ror
  and #$80
  sta seeded_rand_temp1

  lda random_seed2
  ror
  and #$7f
  sta seeded_rand_temp2

  lda random_seed2
  ror
  ror
  and #$80
  clc
  adc random_seed2
  adc #$13
  sta random_seed2
  lda random_seed1
  adc seeded_rand_temp1
  adc seeded_rand_temp2
  sta random_seed1
  rts

random_seed1
  !byte 0
random_seed2
  !byte 0
seeded_rand_temp1
  !byte 0
seeded_rand_temp2
  !byte 0

; *************************************************************************************
; Handler for bomb action countdown and explosion
; Rockford can lay a bomb in a space tile by holding down return and pressing a direction key
; The bomb has a fuse and when time is up, it explodes like a firefly / butterfly / Rockford can
handler_bomb

  cpx #map_bomb | map_unprocessed | $40                  ;if bomb, unprocessed and falling then suspend countdown
  bcs bomb_return
  lda tick_counter
  and #7                                                 ;check only bits 0,1,2 of the tick counter
  cmp #7                                                 ;equals 7
  bne bomb_return                                        ;do nothing if not 7
  txa                                                    ;x register holds current cell value
  clc
  adc #map_anim_state1                                   ;add the next animation frame
  cmp #map_bomb | map_unprocessed | map_anim_state4      ;use last animation frame to check limit
  bcs bomb_explode                                       ;if past last frame, time to explode!
  tax                                                    ;x register holds current cell value, updated with animation frame
  rts

bomb_explode
  ldx #map_deadly                                        ;set the cell to deadly
  jsr show_large_explosion                               ;call the explosion routine

  lda cell_below                                         ;update cell below (as done by other 'standard' handlers)
  ldy #$81
  sta (map_address_low),y
  lda cell_above                                         ;update cell below (as done by other 'standard' handlers)
  ldy #1
  sta (map_address_low),y

bomb_return
  rts

; *************************************************************************************
; Handler for Rockford's actions - moving, pushing rocks, etc
handler_rockford

  stx current_rockford_sprite
  lda rockford_explosion_cell_type
  bne start_large_explosion
  inx
  bne check_for_direction_key_pressed
start_large_explosion
  ldx #map_start_large_explosion
  stx rockford_explosion_cell_type
  rts

check_for_direction_key_pressed
  lda key_press
  sta temp1
  and #(KEY_MASK_UP | KEY_MASK_DOWN | KEY_MASK_LEFT | KEY_MASK_RIGHT)
  bne direction_key_pressed
  ; player is not moving in any direction
  ldx #map_rockford
update_player_at_current_location
  lda #$41
play_movement_sound_and_update_current_position_address
  clc
  adc map_address_low
  sta map_rockford_current_position_addr_low
  lda map_address_high
  adc #0
  sta map_rockford_current_position_addr_high
  rts

direction_key_pressed
  ldx #0
  stx ticks_since_last_direction_key_pressed
  dex
get_direction_index_loop
  inx
  lda temp1
  and direction_key_table,x
  beq get_direction_index_loop
  lda rockford_cell_value_for_direction,x
  beq skip_storing_rockford_cell_type
  sta rockford_cell_value
skip_storing_rockford_cell_type
  ldy neighbour_cell_pointer_from_direction_index,x
  sty neighbour_cell_pointer
  lda neighbour_cell_directions,y
  sta neighbour_cell_contents
  and #$0f
  tay
  ; branch if movement is not possible
  lda obstacle_control,y
  beq check_if_value_is_empty
  ; branch if movement is freely possible
  bmi check_for_return_pressed
  ; trying to move into something difficult to move (e.g. a rock)
  ldy rock_push_directions,x
  beq check_if_value_is_empty
  cpy #$ee  ;Special value used to detect rock has been pushed up
  beq check_push_up
  lda (map_address_low),y
  bne check_if_value_is_empty
  lda neighbour_cell_contents
  ; don't try pushing a rock that's just fallen this tick (bit 6 set at $24c7)
  cmp #$45
  beq check_if_value_is_empty
  dec delay_trying_to_push_rock
  bne check_if_value_is_empty
  ora #$80
  sta (map_address_low),y
  lda #4
  sta delay_trying_to_push_rock
  lda #rock_move_sound
  sta play_sound_fx
check_for_return_pressed
  lda key_press
  and #KEY_MASK_FIRE
  beq store_rockford_cell_value_without_return_pressed
  ; return and direction is pressed. clear the appropriate cell
  jsr check_if_bombs_used  ;Returns accumulator used below
  ldy neighbour_cell_pointer
  sta neighbour_cell_directions,y

check_if_value_is_empty
  ldx rockford_cell_value
  bne update_player_at_current_location
store_rockford_cell_value_without_return_pressed
  lda play_sound_fx
  bne keep_current_sound2  ;don't override a sound effect with Rockford default movement sound
  lda #rockford_move_sound
  sta play_sound_fx
keep_current_sound2
  lda rockford_cell_value
  ldy neighbour_cell_pointer
  sta neighbour_cell_directions,y
  lda map_offset_for_direction,x
  ldx #$80
  jmp play_movement_sound_and_update_current_position_address

;Subroutine to allow Rockford to push a rock upwards
;Needs to check there is a free space above the rock being pushed, allow for the push delay, then continue like other direction pushes
check_push_up
  lda map_address_high  ;store current line pointer high/low on stack
  pha
  lda map_address_low
  pha
  sec
  lda map_address_low
  sbc #$80  ;Need to point upwards 2 lines, so subtract (64 x 2 = 128) from pointer high/low
  sta map_address_low
  bcs no_up_ptr_high_change
  dec map_address_high
no_up_ptr_high_change
  ldy #$41  ;offset the line pointer with Rockford's position
  lda (map_address_low),y  ;this is the cell value 2 rows above Rockford
  bne end_check_up
  dec delay_trying_to_push_rock  ;ok to push up but delay
  bne end_check_up
  lda #map_rock | map_anim_state1  ;delay over, store a rock in the cell 2 rows above Rockford
  sta (map_address_low),y
  lda #4  ;reset the delay for next time
  sta delay_trying_to_push_rock
  pla  ;restore current line pointer high/low from stack
  sta map_address_low
  pla
  sta map_address_high
  jmp store_rockford_cell_value_without_return_pressed  ;continue like side/bottom pushes
end_check_up
  pla  ;restore current line pointer high/low from stack
  sta map_address_low
  pla
  sta map_address_high
  jmp check_if_value_is_empty  ;continue like side/bottom non-pushes

;Subroutine called when pressing return + key direction
;if bombs are allowed, place a bomb in the space of the direction, otherwise just clear the space given by the direction
check_if_bombs_used
  lda bomb_counter
  bne bombs_allowed
  lda #0
  rts

bombs_allowed
  lda neighbour_cell_contents
  beq check_bomb_delay
  lda #0
  rts

check_bomb_delay
  lda bomb_delay
  beq create_a_bomb
  lda #0
  rts

create_a_bomb
  lda #3  ;delay creation of next bomb
  sta bomb_delay
  dec bomb_counter  ;one less bomb to use
  bne skip_no_bombs_message
  lda #message_no_bombs_left
  sta saved_message
  lda #39
  sta message_timer
skip_no_bombs_message
  ;update bombs available on status bar
  jsr update_bombs_available
  lda #map_bomb
  rts

; *************************************************************************************
; Determine next cave to play, which depends on cave sequence, bonus caves and difficulty level
calculate_next_cave_number_and_level

  ldx cave_number
  ldy difficulty_level
  lda cave_play_order,x
  sta cave_number
  bne store_cave_number_and_difficulty_level
  iny
  cpy #6
  bne store_cave_number_and_difficulty_level
  ldy #1
store_cave_number_and_difficulty_level
  sty difficulty_level
  sta cave_number
  rts

; *************************************************************************************
; Setup the status bar with colours
setup_status_bar

  ;Draw status bar
  ldy #40
status_bar_setup_loop
  dey
  lda status_bar_line,y
  sta _SCREEN_ADDR,y
  lda #113  ;numbers etc, white
  sta _COLOUR_SCREEN_ADDR,y
  cpy #0
  bne status_bar_setup_loop

  ;Set colour for diamond, bomb, time and life characters used in status bar
  lda #114  ;diamond, light pink
  sta _COLOUR_SCREEN_ADDR
  lda #115  ;time, light cyan
  sta _COLOUR_SCREEN_ADDR+5
  lda #82  ;life, medium red
  sta _COLOUR_SCREEN_ADDR+24
  lda #118  ;bomb, light blue
  sta _COLOUR_SCREEN_ADDR+27
  rts

; *************************************************************************************
; Set the status bar display with values applied during the games (cave time, diamonds required, etc)
; and apply the status message if set
update_status_bar

  ;draw first part of the status bar which doesn't change
  ldx #24
status_bar_loop_1
  dex
  lda status_bar_line,x
  sta _SCREEN_ADDR,x
  cpx #0
  bne status_bar_loop_1

  ;set the colours for the bomb and life special characters
  lda #82  ;life, medium red
  sta _COLOUR_SCREEN_ADDR+24
  lda #118  ;bomb, light blue
  sta _COLOUR_SCREEN_ADDR+27

  cpy #message_none
  beq skip_clear_status_colours

  ;for the message, clear the colours for the bomb and life special characters
  lda #113  ;numbers etc, white
  sta _COLOUR_SCREEN_ADDR+24
  sta _COLOUR_SCREEN_ADDR+27

skip_clear_status_colours

  ;draw second part of the status bar which may be replaced with a message
  ldx #16
status_bar_loop_2
  dex
  lda status_bar_line+24,x
  sta draw_status_bar_char+1  ;self-mod, set standard status bar character

  cpy #message_none
  beq draw_status_bar_char
  lda status_messages-1,y
  dey
  sta draw_status_bar_char+1  ;self-mod, set status bar character to message
  jmp draw_status_bar_char

draw_status_bar_space
  lda #32
  sta draw_status_bar_char+1  ;self-mod, set status bar character to space

draw_status_bar_char
  lda #32
  sta _SCREEN_ADDR+24,x
  cpx #0
  bne status_bar_loop_2

  rts

; *************************************************************************************
; Updates the score and bonus with accumulator value and performs the bonus life actions
update_score

  clc
  adc score_low
  sta score_low
  bcc score_skip_high
  inc score_high
score_skip_high

  ;Check for bonus every 500 points
  ;Subtract score from previous bonus (which start at zero)
  sec
  lda score_low
  sbc bonus_low
  sta result_low
  lda score_high
  sbc bonus_high
  sta result_high

  ;Check if the result is over 500 (high byte = 2 or 1 and low byte >= 244)
  lda result_high
  cmp #1
  bcc score_return  ; less than
  bne award_bonus_life  ;greater than
  lda result_low
  cmp #244
  bcc score_return  ; less than

  ;Set the bonus score to the current score for checking next time
award_bonus_life
  lda score_low
  sta bonus_low
  lda score_high
  sta bonus_high
  lda #$27  ;Set the bonus timer to animate the pathway/space sprites
  sta bonus_timer
  inc player_lives
  jsr update_player_lives

  ;play sound
  lda #bonus_life_sound
  sta play_sound_fx

  ;update message bar
  lda #message_bonus_life
  sta saved_message
  lda #39
  sta message_timer

score_return
  rts

bonus_low
  !byte 0
bonus_high
  !byte 0
result_low
  !byte 0
result_high
  !byte 0

; *************************************************************************************
update_player_score

  ldy score_low
  lda score_high
  sty wip_int
  sta wip_int+1
  jsr two_bytes_to_ASCII
  ldx #0
plot_score
  lda output16,x
  sta status_bar_line+17,x
  inx
  cpx #5
  bne plot_score
  rts

; *************************************************************************************
update_diamonds_required
  jsr clear_output8
  lda diamonds_required
  jsr single_byte_to_ASCII

  lda output8
  sta status_bar_line+1
  lda output8+1
  sta status_bar_line+2
  lda output8+2
  sta status_bar_line+3
  rts

; *************************************************************************************
update_bombs_available

  lda param_bombs
  beq cave_has_no_bombs

  jsr clear_output8
  lda bomb_counter
  jsr single_byte_to_ASCII

  lda output8
  sta status_bar_line+29
  lda output8+1
  sta status_bar_line+30
  lda output8+2
  sta status_bar_line+31
cave_has_no_bombs
  rts

; *************************************************************************************
update_cave_time

  jsr clear_output8
  lda time_remaining
  jsr single_byte_to_ASCII

  lda output8
  sta status_bar_line+6
  lda output8+1
  sta status_bar_line+7
  lda output8+2
  sta status_bar_line+8
  rts

; *************************************************************************************
update_player_lives

  jsr clear_output8
  lda player_lives
  jsr single_byte_to_ASCII

  lda output8
  sta status_bar_line+25
  lda output8+1
  sta status_bar_line+26
  ;output8+2 (100+ lives deliverately not set)
  rts

; *************************************************************************************
; Convert byte value in A into readable ASCII returned in output8 
single_byte_to_ASCII

  ldx #1
  stx wip8c
  inx
  ldy #$40
b2A_1
  sty wip8b
  lsr
b2A_2
  rol
  bcs b2A_3
  cmp wip8a,x
  bcc b2A_4
b2A_3
  sbc wip8a,x
  sec
b2A_4
  rol wip8b
  bcc b2A_2
  tay
  cpx wip8c
  lda wip8b
  bcc b2A_5
  beq b2A_6
  stx wip8c
b2A_5
  eor #$30
  ;set output using counter in temp1
  stx temp2  ;preserve X
  ldx temp1
  sta output8,x
  inc temp1
  ldx temp2  ;restore X
b2A_6
  tya
  ldy #$10
  dex
  bpl b2A_1
  rts

clear_output8
  lda #0
  sta temp1
  lda #32
  sta output8
  sta output8+1
  sta output8+2
  rts

wip8a
  !byte 128,160,200
wip8b
  !byte 1
wip8c
  !byte 1

output8
  !byte 32,32,32  ;spaces

; *************************************************************************************
; Convert byte values in wip address into readable ASCII returned in output16 
two_bytes_to_ASCII
  ldy #0
  sty temp1
w2A_next
  ldx #0
w2A_slp
  lda wip_int
  sec 
  sbc w2A_table,y
  sta wip_int
  lda wip_int+1
  iny 
  sbc w2A_table,y
  bcc w2A_add
  sta wip_int+1
  inx 
  dey 
  clc 
  bcc w2A_slp
w2A_add
  dey
  lda wip_int
  adc w2A_table,y
  sta wip_int
  txa
  ora #$30
  ldx temp1
  sta output16,x
  inc temp1
  iny
  iny
  cpy #8
  bcc w2A_next
  lda wip_int
  ora #$30
  ldx temp1
  sta output16,x
  inx
  lda #32
  sta output16,x
  rts

w2A_table
  !word 10000
  !word 1000
  !word 100
  !word 10

output16
  !byte 0,0,0,0,0,0
wip_int
  !byte 0,0

; ****************************************************************************************************
; Populate the cave with tiles using the pseudo-random method
;   Tiles are applied to the map if the tile already there is a 'null' tile (from populate_cave_from_loaded_data)
;   These tiles may be the cave default (often dirt) or a tile determined in a pseudo-random fashion
;   A pseudo-random value is calculated by a function using the seed value for the cave difficulty level
;   The pseudo-random value is returned in random_seed1
;   This value is compared with each of the 4 tile probability values for the cave
;   If random_seed1 is not less than the probability value, the corresponding tile is plotted
;   For some caves, a second tile may be required below the pseudo-random one
;   These tiles are held in a 'beneath' row, populated with second tile values from cave parameters
;   If non-zero, the 'beneath' row tile will override random tiles (when on the next row)
; ****************************************************************************************************
populate_cave_tiles_pseudo_random

  ldx difficulty_level               ; Use difficulty_level (values 1 to 5) for the random seed value to use
  dex
  lda param_random_seeds,x           ; Set random_seed2 to cave random seed
  sta random_seed2
  lda #$00                           ; Set random_seed1 to 0
  sta random_seed1

  lda #$16                           ; Set number of rows to 22 (includes steel top and bottom rows)
  sta populate_row_counter
  lda #<tile_map_row_1               ; Point to start of map (low)
  sta map_address_low
  lda #>tile_map_row_1               ; Point to start of map (high)
  sta map_address_high
populate_cave_row
  ldy #$00                           ; Set column start to 0
populate_cave_tile
  lda tile_below_store_row,y         ; Needed for BD2 caves G, K, get previously stored tile
  sta tile_override                  ; The override tile might need to replace the random tile

  ldx param_initial_fill_tile        ; Set cave fill tile
  jsr pseudo_random                  ; Call pseudo-random routine returning random_seed1 in the accumulator
  cmp param_tile_probability         ; Compare pseudo-random value with first cave probability parameter
  bcs check_next_probability1        ; If random_seed1 is not less than cave random compare parameter, don't plot the cave random object, try next one
  ldx param_tile_for_probability     ; Set the designated cave random tile
  lda param_tile_for_prob_below      ; Needed for BD2 caves G, K, set the tile below current one
  sta tile_below_store_row,y         ; to the parameter value for it (this value is 0 for most caves)

check_next_probability1
  lda random_seed1
  cmp param_tile_probability+1       ; Compare pseudo-random value with second cave probability parameter
  bcs check_next_probability2        ; If random_seed1 is not less than cave random compare parameter, don't plot the cave random object, try next one
  ldx param_tile_for_probability+1   ; Set the designated cave random tile
  lda param_tile_for_prob_below+1    ; Needed for BD2 caves G, K, set the tile below current one
  sta tile_below_store_row,y         ; to the parameter value for it (this value is 0 for most caves)

check_next_probability2
  lda random_seed1
  cmp param_tile_probability+2       ; Compare pseudo-random value with third cave probability parameter
  bcs check_next_probability3        ; If random_seed1 is not less than cave random compare parameter, don't plot the cave random object, try next one
  ldx param_tile_for_probability+2   ; Set the designated cave random tile
  lda param_tile_for_prob_below+2    ; Needed for BD2 caves G, K, set the tile below current one
  sta tile_below_store_row,y         ; to the parameter value for it (this value is 0 for most caves)

check_next_probability3
  lda random_seed1
  cmp param_tile_probability+3       ; Compare pseudo-random value with forth cave probability parameter
  bcs check_probability_end          ; If random_seed1 is not less than cave random compare parameter, don't plot the cave random object, continue
  ldx param_tile_for_probability+3   ; Set the designated cave random tile
  lda param_tile_for_prob_below+3    ; Needed for BD2 caves G, K, set the tile below current one
  sta tile_below_store_row,y         ; to the parameter value for it (this value is 0 for most caves)

check_probability_end
  lda (map_address_low),y            ; Get the map tile added when the cave was loaded
  cmp #$0f                           ; Check if a null tile #$0f. This occurs at this late stage to preserve the ongoing random seed calculations
  beq apply_random_tile_ok           ; Allow replacement with the random tile where is currently null
  lda #0                             ; Needed for BD2 caves G, K, reset the tile below current one
  sta tile_below_store_row,y         ; It must not be used later for override
  jmp check_tile_override            ; Now check for a previous override

apply_random_tile_ok
  txa                                ; The loaded map tile was a null, so replace with the random tile instead
  sta (map_address_low),y

check_tile_override
  lda tile_override
  beq skip_below_tile                ; Needed for BD2 caves G, K, check the override tile is 0
  sta (map_address_low),y            ; If not then apply the override tile
  lda #0                             ; Reset the tile below current one for next time
  sta tile_below_store_row,y

skip_below_tile
  iny                                ; Add 1 to column count
  cpy #$28                           ; Check if 40 columns plotted
  bne populate_cave_tile             ; Continue if not
  lda #$40                           ; Add 64 to map_address_low
  jsr add_a_to_ptr
  dec populate_row_counter
  lda populate_row_counter
  beq tiles_pseudo_return            ; Rows are zero, so end
  jmp populate_cave_row              ; Continue to plot the next cave row
tiles_pseudo_return
  rts

populate_row_counter
  !byte 0

tile_override
  !byte 0

; *************************************************************************************
load_cave_for_version

  ;Set cave letter to load
  lda cave_number
  cmp load_cave_number_stored        ; Check if the cave is already stored
  beq cave_already_loaded            ; Skip if already loaded
  clc
  adc #65
  sta name_of_cave+4

  ;SETLFS
  lda #$01  ;1 is logical file number
  ldx #$08  ;8 is device number (disk)
  ldy #$01  ;1 means use secondary address (load into memory location set in PRG first 2 bytes)
  jsr _KERNAL_SETLFS  ;Kernal: SETLFS, set logical first and second addresses

  ;SETNAM
  ldx #<name_of_cave
  ldy #>name_of_cave
  lda #5  ;number of characters in filename (e.g. BD1-A for Boulder Dash version 1, cave A)
  jsr _KERNAL_SETNAM  ;Kernal: SETNAM, set filename

  ;LOADSP
  lda #$00  ;0 set operation to be load (not verify)
  jsr _KERNAL_LOADSP  ;Kernal: LOADSP, load into memory from device

  lda cave_number
  sta load_cave_number_stored

cave_already_loaded
  rts

;Version prefix populated in version selection
name_of_cave
  !scr "BD1-A"

;Initially cave $ff isn't a valid cave, so will always loads cave A
load_cave_number_stored
    !byte $ff                          

; *************************************************************************************
; Copy a number of bytes (in copy size variable) from source to target memory locations
copy_memory

  ldy #0
  ldx copy_size+1
  beq copy_remaining_bytes
copy_a_page
  lda (screen_addr1_low),y
  sta (screen_addr2_low),y
  iny
  bne copy_a_page
  inc screen_addr1_high
  inc screen_addr2_high
  dex
  bne copy_a_page
copy_remaining_bytes
  ldx copy_size
  beq copy_return
copy_a_byte
  lda (screen_addr1_low),y
  sta (screen_addr2_low),y
  iny
  dex
  bne copy_a_byte

copy_return
  rts

copy_size
  !byte 0, 0

; *************************************************************************************
; Custom character set for fonts and sprites
; IMPORTANT: Address must be fixed to this location for custom characters to work
* = $2000
!binary "font.bin"
!source "spr.asm"

; *************************************************************************************
!source "vars.asm"  ;tables of data
!source "interrupt.asm"  ;interrupt routines for joystick, keyboard input and sounds

; *************************************************************************************
; Cave tile map
;
; Each row has 40 bytes used for the tiles in the game, 24 unused
; IMPORTANT: Address must be $1000, $2000 etc, not $1100 for example!
* = $3000

tile_map_row_0  ;top border
  !fill 64
tile_map_row_1  ;1-20 rows between the borders
  !fill (64*19)
tile_map_row_20
  !fill 64
tile_map_row_21  ;bottom border
  !fill 64
tile_below_store_row  ;special row for pseudo-random generated caves with extra-tile below the random one
  !fill 64

; *************************************************************************************
; Cave parameters and map for one cave
; IMPORTANT: Below is needed to point to the correct memory location for loading caves
* = $3600
!source "cavedata.asm"

; *************************************************************************************
; Big Rockford and instructions

big_rockford_instructions
  !fill 12, " "
  !scr "boulder dash                "

  !fill 40, " "

  !fill 12, " "
  !scr "rockford must gather all    "

  !fill 12, " "
  !scr "diamonds needed to complete "

  !byte 32,32,209,210,211,212,32,32,32,32,32,32
  !scr "each cave and reach the     "

  !byte 32,32,213,214,79,215,216,32,32,32,32,32
  !scr "exit before time runs out   "

  !byte 32,32,217,218,219,220,221,32,222,32,32,32
  !fill 28, " "
  
  !byte 32,32,223,224,225,226,227,228,229,230,32,32
  !scr "use joystick 1 to move      "

  !byte 32,32,231,232,233,234,235,236,229,236,32,32
  !scr "fire + direction clears     "

  !byte 32,32,237,238,32,239,240,241,229,242,32,32
  !scr "space, pushes rocks, grabs  "

  !byte 32,32,32,32,32,32,32,32,243,32,32,32
  !scr "diamonds or plants bombs    "

  !fill 40, " "

  !fill 12, " "
  !scr "press q to restart a cave   "

  !fill 12, " "
  !scr "press space to pause        "

  !fill 40, " "

  !fill 12, " "
  !scr "select version              "


; *************************************************************************************
; sound effects
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

end_of_game