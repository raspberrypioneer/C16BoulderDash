################################################################################
# create_d64.py - Python program to create d64, d71 etc files and add PRG files to it
#  Supported on SD2IEC:
#    d64: 170 KB,  664 free blocks, 144 files, no subfolders
#    d71: 340 KB, 1328 free blocks, 144 files, no subfolders
#    d81: 800 KB, 3160 free blocks, 296 files in root, subfolders
#

from d64 import DiskImage  #library to create disk image files (.d64, .d71, .d80, .d81, .d82) 
from os import path
from pathlib import Path
import sys

#Accept disk type parameter if available else keep default
valid_disk_types = ["d64", "d71", "d80", "d81", "d82"]  #d64, d71 and d81 are supported on SD2IEC
disk_type = "d64"
if len(sys.argv) == 2:
    if sys.argv[1] in valid_disk_types:
        disk_type = sys.argv[1]

disk_file_path = "d64/C16 Boulder Dash"
disk_label = b"C16 BOULDER DASH"
disk_id = b"00"
prg_list = ["BD"]  #program prg files
version_codes = ["BD1","BD2","BD3","BP1","AR1","AR2"]  #cave prefixes combined with letters to make a cave prg file
cave_letters = ['A','B','C','D','Q','E','F','G','H','R','I','J','K','L','S','M','N','O','P','T','Z']

base_path = path.dirname(path.abspath(__file__))
base_path = path.join(base_path, "..")
disk_path = path.join(base_path, disk_file_path + "." + disk_type)
if not path.exists(disk_path):
    DiskImage.create(disk_type, Path(disk_path), disk_label, disk_id)

disk_image = DiskImage(disk_path, mode='w')
with disk_image as image:
    for prg_name in prg_list:
        prg_on_disk_image = image.path(prg_name.encode()).open(mode="w", ftype="prg")
        with open(path.join(base_path, "prg", prg_name), "rb") as file:
            prg_on_disk_image.write(file.read())
        prg_on_disk_image.close

    for version in version_codes:
        for letter in cave_letters:
            cave_file = version + "-" + letter
            prg_on_disk_image = image.path(cave_file.encode()).open(mode="w", ftype="prg")
            with open(path.join(base_path, "prg", cave_file), "rb") as file:
                prg_on_disk_image.write(file.read())
            prg_on_disk_image.close

    image.close
