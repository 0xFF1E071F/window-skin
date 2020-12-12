
include windows.inc
include kernel32.inc
include user32.inc
include Comctl32.inc
include shell32.inc


includelib kernel32.lib
includelib user32.lib
includelib Comctl32.lib
includelib shell32.lib
include gdi32.inc
includelib gdi32.lib

DlgProc			PROTO	:HWND,:UINT,:WPARAM,:LPARAM

.const

;window-skin.dlg
IDD_DIALOG1						equ 101
IDC_BTN1						equ 1001

;window-skin.Rc


;#########################################################################
.data

hdc					dd 0
hdc_bitmap 			dd 0
hBitmap 			dd 0
hRgn				dd 0
hBrush				dd 0
.data?

hInstance			dd ?

;#########################################################################
