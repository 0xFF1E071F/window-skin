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
		.if wParam == IDC_BTN1
			.if cntr==1
				mov cntr,2
				
				; Set Brush
				invoke  LoadBitmap,hInstance,BmpID1
		        invoke  CreatePatternBrush,eax
				mov hBrush, eax	
				
				; Select region from resource
				invoke  FindResource,hInstance,addr ResName1,addr ResType
		        mov hRes, eax
			.elseif cntr==2
				mov cntr,1
				; Set Brush
				invoke  LoadBitmap,hInstance,BmpID2 
		        invoke  CreatePatternBrush,eax
				mov hBrush, eax
				
				; Select region from resource
				invoke  FindResource,hInstance,addr ResName2,addr ResType
		        mov hRes, eax
			.endif
			; Fill background image
			invoke FillRgn,hdc,hrBg,hBrush
			
			; Add region to window
			invoke  LoadResource,hInstance, hRes
	        mov     ResPoint, eax
	        invoke  SizeofResource,hInstance,hRes
	        mov     ResSize, eax
	        invoke  LockResource,ResPoint
	        mov     ResPoint, eax	
	        invoke  ExtCreateRegion,NULL,ResSize,ResPoint
	        invoke  SetWindowRgn,hWin,eax,TRUE
	        
	    .elseif wParam == IDC_BTN2
	    	invoke  SendMessage,hWin,WM_CLOSE,0,0
		.endif
	.elseif eax==WM_ERASEBKGND
		.if cntr==0
			mov cntr,1
			; Set color background fill on start
			invoke GetDC,hWin
			mov hdc,eax
			invoke CreateSolidBrush,000ffh
			mov hBrush, eax
			invoke CreateRectRgn,0,0,300,300
			mov hrBg,eax 
			
			invoke FillRgn,hdc,hrBg,hBrush
		.endif
	.elseif eax==WM_CLOSE
		; De;ete all objects
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
