.386
.model flat, stdcall  ;32 bit memory model
option casemap :none  ;case sensitive

include window-skin.inc

.code

start:

	invoke GetModuleHandle,NULL
	mov		hInstance,eax

    invoke InitCommonControls
	invoke DialogBoxParam,hInstance,IDD_DIALOG1,NULL,addr DlgProc,NULL
	invoke ExitProcess,0

;########################################################################

DlgProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
	mov		eax,uMsg
	.if eax==WM_INITDIALOG
		
	.elseif eax==WM_COMMAND
		.if wParam == 1001
			
		.endif
	.elseif eax==WM_ERASEBKGND
		; Set color background fill on start
		invoke GetDC,hWin
		mov hdc,eax
		invoke CreateSolidBrush,000ffh
		mov hBrush, eax
		invoke CreateRectRgn,0,0,300,300
		mov hrBg,eax 
		
		invoke FillRgn,hdc,hrBg,hBrush
	.elseif eax==WM_CLOSE
		invoke DeleteObject, hBrush
		invoke DeleteObject, hrBg
		invoke ReleaseDC,hWin,hdc
		
		invoke EndDialog,hWin,0
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

DlgProc endp

end start
