#SingleInstance force

DetectHiddenWindows, On
SetTitleMatchMode, 2
SetTitleMatchMode, Fast

;---快捷键---
; # Win
; ! Alt 
; ^ Control 
; + Shift 

;------速盘急速版破解，自动更改日期和开始下载--------

;今天真实日期
Today = %A_YYYY%/%A_MM%/%A_DD%

;昨天的日期
Yesterday  = %A_Now%   ;必须为 YYYYMMDDHH24MISS 格式才能使用下面的函数
EnvAdd, Yesterday, -1, days
FormatTime, Yesterday, %Yesterday%, ShortDate

TheDate = %Today%

SetDate()
{
    global

    if (TheDate = Today)
        TheDate = %Yesterday%
    else
        TheDate = %Today%

    RunWait, %comspec% /c date %TheDate%,,Hide
    return
}

DownLoad()
{
    SetDate()

    Run,supan
    WinWait,速盘 - 极速版
    Sleep,100
    Send {Click 650,123}
    Send {Click 1493,239}
    Send !{TAB}
    Sleep,70000

    IfWinExist,速盘 - 极速版
    {
        WinActivate
        WinClose
        Sleep,500
        IfWinExist, Confirm
            Send {Enter}
        Sleep,1500
        DownLoad()
    }
    return
}

^\::DownLoad()

;Vim 中 CapsLock 和 Ctrl+[ 互换
#IfWinActive, ahk_class Vim
    Capslock::^[
    ;^[::Capslock
#IfWinActive

;WheelUp::msgbox,滚轮向上滚动
;WheelDown::msgbox,滚轮向下滚动

;四向滚轮
WheelLeft::^+TAB
WheelRight::^TAB

;MButton::msgbox,滚轮点击
MButton::
SoundGet, master_mute, , mute
SoundSet, +1, , mute
if (master_mute = "On")
{
    ;系统音量调节
    ;Run,%windir%\System32\SndVol.exe -f 49825268

    ;右下角的 thinkpad 音量调节
    ControlClick, x2145 y33, ahk_class Shell_TrayWnd
}
else
{
    SoundSet, 10
}
return

;XButton1::msgbox,四键鼠标
;XButton2::msgbox,五键鼠标
XButton1::
IfWinActive, ahk_class CabinetWClass
    Send {Backspace}
else
    Send ^w
return
;XButton2::Backspace
XButton2::^TAB
;XButton2::^+TAB

;---右 Win 键运行对话框---
;RWin:: #r
;^-::#e

;---关闭显示器---
; Wait for it to be released because otherwise the hook state gets reset
; while the key is down, which causes the up-event to get suppressed,
; which in turn prevents toggling of the ScrollLock state/light:
~ScrollLock::
KeyWait, ScrollLock
GetKeyState, ScrollLockState, ScrollLock, T
If ScrollLockState = D
{
    RunWait, %comspec% /c powercfg /X -standby-timeout-ac 2,,Hide
    ;RunWait, %comspec% /c powercfg /X -monitor-timeout-ac 2 && powercfg /X -standby-timeout-ac 2,,Hide
    RunWait, rundll32.exe user32.dll`,LockWorkStation    ; 要运行的目标程序中有逗号则必须被转义
    Sleep,500
    SendMessage,0x112,0xF170,2,,Program Manager
} else {
    RunWait, %comspec% /c powercfg /X -standby-timeout-ac 60,,Hide
}
return

;SendMessage,0x112,0xF170,2,,Program Manager
            ;0x112：WM_SYSCOMMAND，
            ;0xF170：SC_MONITORPOWER，
                    ;2：关闭。
                    ;1：activate thedisplay's "low power" mode。
                    ;-1：turn the monitor on

;---Chromium---
^q:: toggleWin("- Google Chrome")

;---Total Commander---
;^w:: toggleWin("Total Commander")

;---Kodi---
^1:: toggleWin("ahk_class Kodi")

;---Premiere---
^4:: toggleWin("Adobe Premiere Pro CC 2018")

;---firefox---
^2:: 
IfWinExist, Mozilla Firefox （隐私浏览）    ;注意这里不要加双引号，否则判断出错
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

;---显示隐藏有道词典迷你窗口(新版本词典老出错)---
<^Up::
<^Down::^!x
;ControlGetFocus, Edit1, ahk_class YdMiniModeWndClassName
;return

;---有道词典标准窗口活动时下列快捷键有效---
#IfWinActive, ahk_class YodaoMainWndClass
    Up::moveWindow("Up")
    Down::moveWindow("Down")
    Left::moveWindow("Left")
    Right::moveWindow("Right")
    /::^!v
#IfWinActive

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

;---有道词典划词窗口活动时下列快捷键有效---
#IfWinActive, YoudaoStrokeWnd
    ;---加入/删除生词本---
    d::^!s
#IfWinActive

;---移动窗口函数---
moveWindow(Direct)
{
    WinGetClass, class, A

    WinGetPos, x, y, Width, Height, ahk_class %class%
    Width := 300
    Height := 300

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
