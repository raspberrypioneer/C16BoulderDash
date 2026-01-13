; Screen sprite cache used to avoid drawing a sprite if it hasn't changed
; The cache overwrites version data which is just used once at the start
screen_cache_map

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

version_choices_text
  !scr "boulder dash 1 "
  !byte 0
  !scr "boulder dash 2 "
  !byte 0
  !scr "boulder dash 3 "
  !byte 0
  !scr "boulder dash +1"
  !byte 0
  !scr "arno dash 1    "
  !byte 0
  !scr "arno dash 2    "
  !byte 0

version_selection_cycle_up
  !byte 5,0,1,2,3,4
version_selection_cycle_down
  !byte 1,2,3,4,5,0

cave_version_prefix
  !scr "BD1-"
  !scr "BD2-"
  !scr "BD3-"
  !scr "BP1-"
  !scr "AR1-"
  !scr "AR2-"

end_of_version_data