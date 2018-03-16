#SingleInstance force

DetectHiddenWindows,On
SetTitleMatchMode, 2
SetTitleMatchMode, Fast

;---右 Win 键运行对话框---
RWin::#r

;---关闭显示器---
F7::SendMessage,0x112,0xF170,2,,Program Manager
                                                ;0x112：WM_SYSCOMMAND，
                                                ;0xF170：SC_MONITORPOWER，
                                                        ;2：关闭。
                                                        ;1：activate thedisplay's "low power" mode。
                                                        ;-1：turn the monitor on

;---PotPlayer---
^1:: toggleWin("PotPlayer")

; 自动暂停播放
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
IfWinExist, Mozilla Firefox （隐私浏览）            ;注意这里不要加双引号，否则判断出错
    toggleWin("Mozilla Firefox （隐私浏览）")
else
    toggleWin("Mozilla Firefox")
return

;---隐藏显示窗口---
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

;---遍历窗口----
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

;---显示隐藏有道词典迷你窗口---
<^Up::
<^Down::
^!m
ControlGetFocus, Edit1, ahk_class YdMiniModeWndClassName
return

;---有道词典迷你窗口活动时下列快捷键有效---
#IfWinActive, ahk_class YdMiniModeWndClassName
    ;---移动有道词典迷你窗口---
    Up::moveWindow("Up")
    Down::moveWindow("Down")
    Left::moveWindow("Left")
    Right::moveWindow("Right")

    ;---发音---
    /::^!v
#IfWinActive

;---移动窗口函数---
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

    ;移动单词查询内容窗口
    WinMove, ahk_class YdMiniCefWnd, , x, y + Height
}

;
; ----------------------------------------------------------------------------
;
; # Wind
; ! Alt 
; ^ Control 
; + Shift 

;- 360安全浏览器 9.1
;360安全浏览器 9.1【无痕/小号浏览】

;---test，双击 win 键---
;RWin::
;if (A_PriorHotkey = "RWin" and A_TimeSincePriorHotkey < 400)
;{
;    send #r
;}
;return

;---test，右 win 键代替鼠标右键---
;RWin::AppsKey

;---test，~ 符号表示不影响按键的原来功能 ---
;~ScrollLock::msgbox,scroll lock ...
