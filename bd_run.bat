@echo off
cd .\d64
::VICE: Specify the C16 / Plus4 model you want to emulate: pal or ntsc
::C:\Users\spwil\Documents\Commodore\Tools\GTK3VICE-3.3-win32-r35872\xplus4.exe -model c16pal "C16 Boulder Dash.d64:bd"
::C:\Users\spwil\Documents\Commodore\Tools\GTK3VICE-3.3-win32-r35872\xplus4.exe -model c16ntsc "C16 Boulder Dash.d64:bd"
::C:\Users\spwil\Documents\Commodore\Tools\GTK3VICE-3.3-win32-r35872\xplus4.exe -model plus4pal "C16 Boulder Dash.d64:bd"
::C:\Users\spwil\Documents\Commodore\Tools\GTK3VICE-3.3-win32-r35872\xplus4.exe -model plus4ntsc "C16 Boulder Dash.d64:bd"
::YAPE: Provides better emulation than VICE
C:\Users\spwil\Documents\Commodore\Tools\yape1.3.0\Yape.exe /DISK8:"C16 Boulder Dash.d64" /TYPE:LOAD"BD",8
::C:\Users\spwil\Documents\Commodore\Tools\yape1.3.0\Yape.exe /DISK8:"C16 Boulder Dash.d81" /TYPE:LOAD"BD",8
cd ..