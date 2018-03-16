#SingleInstance force

DetectHiddenWindows,On
SetTitleMatchMode, 2
SetTitleMatchMode, Fast

;---�� Win �����жԻ���---
RWin::#r

;---�ر���ʾ��---
F7::SendMessage,0x112,0xF170,2,,Program Manager
                                                ;0x112��WM_SYSCOMMAND��
                                                ;0xF170��SC_MONITORPOWER��
                                                        ;2���رա�
                                                        ;1��activate thedisplay's "low power" mode��
                                                        ;-1��turn the monitor on

;---PotPlayer---
^1:: toggleWin("PotPlayer")

; �Զ���ͣ����
;if (i = 1 or i = "")
;{
;    send {Space}
;    i := toggleWin("PotPlayer")
;}
;else if (i = -1)
;{
;    i := toggleWin("PotPlayer")
;    send {Space}
;}
;return

;---vedit---
^2:: toggleWin("Movavi Video Editor Plus")
^4:: toggleWin("Adobe Premiere Pro CC 2018")

;---firefox---
^q:: 
IfWinExist, Mozilla Firefox ����˽�����            ;ע�����ﲻҪ��˫���ţ������жϳ���
    toggleWin("Mozilla Firefox ����˽�����")
else
    toggleWin("Mozilla Firefox")
return

;---������ʾ����---
toggleWin(win_title)
{
    IfWinNotExist, %win_title%
        return 0

    IfWinActive
    {
        WinHide
        Send !{TAB}
        return -1
    }
    else
    {
        WinShow
        WinActivate
        return 1
    }
}

;---��������----
;^9::show_all_win("ahk_class PotPlayer64")

show_all_win(win_title)
{
    DetectHiddenWindows,On
    WinGet, id, list, %win_title%
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        WinGetClass, this_class, ahk_id %this_id%
        MsgBox, 4, , Visiting All Windows`n%a_index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
        IfMsgBox, NO, break

        ;if (this_title != "Video Editor Plus")
        ;    WinShow, ahk_id %this_id%
        ;else
        ;{
        ;    WinHide, ahk_id %this_id%
        ;    Send !{TAB}
        ;}
    }
}

;---��ʾ�����е��ʵ����㴰��---
<^Up::
<^Down::
^!m
ControlGetFocus, Edit1, ahk_class YdMiniModeWndClassName
return

;---�е��ʵ����㴰�ڻʱ���п�ݼ���Ч---
#IfWinActive, ahk_class YdMiniModeWndClassName
    ;---�ƶ��е��ʵ����㴰��---
    Up::moveWindow("Up")
    Down::moveWindow("Down")
    Left::moveWindow("Left")
    Right::moveWindow("Right")

    ;---����---
    /::^!v
#IfWinActive

;---�ƶ����ں���---
moveWindow(Direct)
{
    WinGetClass, class, A

    WinGetPos, x, y, Width, Height, ahk_class %class%

    if (Direct = "Up")
        y := y - Height
    else if (Direct = "Down")
        y := y + Height
    
    if (Direct = "Left")
        x := x - Width
    else if (Direct = "Right")
        x := x + Width

    if (x < 0)
        x := 0
    else if ( (x + Width) > A_ScreenWidth)
        x := A_ScreenWidth - Width

    if (y < 0)
        y := 0
    else if ( (y + Height) > A_ScreenHeight)
        y := A_ScreenHeight - Height

    WinMove, ahk_class %class%, , x, y

    ;�ƶ����ʲ�ѯ���ݴ���
    WinMove, ahk_class YdMiniCefWnd, , x, y + Height
}

;
; ----------------------------------------------------------------------------
;
; # Wind
; ! Alt 
; ^ Control 
; + Shift 

;- 360��ȫ����� 9.1
;360��ȫ����� 9.1���޺�/С�������

;---test��˫�� win ��---
;RWin::
;if (A_PriorHotkey = "RWin" and A_TimeSincePriorHotkey < 400)
;{
;    send #r
;}
;return

;---test���� win ����������Ҽ�---
;RWin::AppsKey

;---test��~ ���ű�ʾ��Ӱ�찴����ԭ������ ---
;~ScrollLock::msgbox,scroll lock ...
