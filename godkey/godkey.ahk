#SingleInstance force

DetectHiddenWindows, On
SetTitleMatchMode, 2
SetTitleMatchMode, Fast

;---功能键含义---
; # Win
; ! Alt 
; ^ Control 
; + Shift 

;==============程序加载时根据当前代理状态更改图标===========
ServerAddr := "127.0.0.1:1088"

OutputVar := ReadProxy()
if (OutputVar = 1){
    SetTrayIcon(ServerAddr)
} else {
    SetTrayIcon("")
}

;================创建内存盘文件夹=================
Run, %comspec% /c mkdir "z:\TEMP" "z:\Chrome" "z:\Download" "z:\FireFox" "z:\INetCache" "z:\360 Browser",,Hide

;================速盘急速版破解，自动更改日期和开始下载=================

;------今天实际日期--------
Today = %A_YYYY%/%A_MM%/%A_DD%

;------昨天的日期--------
Yesterday  = %A_Now%   ;必须为 YYYYMMDDHH24MISS 格式才能使用下面的函数
EnvAdd, Yesterday, -1, days
FormatTime, Yesterday, %Yesterday%, ShortDate

TheDate = %Today%

;------设置系统日期--------
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

;------启动程序自动开始下载--------
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

;=====================快速查看、禁用、启用 IE 代理==============================

;------读取 IE 代理--------
ReadProxy() {
    ;RegRead, OutputVar, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\, ProxyEnable
    RegRead, OutputVar, HKEY_USERS\S-1-5-21-2649311137-1019525462-828708016-1001\Software\Microsoft\Windows\CurrentVersion\Internet Settings, ProxyEnable
    Return OutputVar
}

;------设置 IE 代理--------
SetProxy(Server) {
    Run, SetProxy.exe "%Server%", , Hide, OutputVarPID
}

;------设置托盘图标--------
SetTrayIcon(Server) {
    ;Menu, Tray, NoIcon     ; 隐藏托盘图标
    if (Server = ""){
        Menu, Tray, Icon, DirectLink.ico
        Menu, Tray, Tip , Direct Link
    } else {
        Menu, Tray, Icon, ProxyLink.ico
        Menu, Tray, Tip , Proxy Server : %Server%
    }
    Menu, Tray, Icon        ; 显示托盘图标
}

;------快捷键切换代理状态--------
F10::
; 检测热键的单次, 两次和三次按下. 这样允许热键根据您按下次数的多少
; 执行不同的操作：
if winc_presses > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    winc_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器：
winc_presses = 1
SetTimer, KeyWinC, 300 ; 在 300 毫秒内等待更多的键击.
return

KeyWinC:
SetTimer, KeyWinC, off
if winc_presses = 1 ; 此键按下了一次.
{
    OutputVar := ReadProxy()
    if (OutputVar = 1){
        SetProxy("")
        SetTrayIcon("")
    } else {
        SetProxy(ServerAddr)
        SetTrayIcon(ServerAddr)
    }
}
else if winc_presses >= 2 ; 此键按下至少两次.
{
    Run,rundll32.exe shell32.dll`, Control_RunDLL inetcpl.cpl`, `,4L
    Sleep,200
    Send !l
}
; 不论触发了上面的哪个动作, 都对 count 进行重置
; 为下一个系列的按下做准备:
winc_presses = 0
return

;============================关闭、打开显示器并设定休眠时间====================
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

;======================按键重映射==========================

;---Capslock和ESC互换---
Capslock::ESC
ESC::Capslock

;---右 Win 键运行对话框---
RWin:: #r

;======================隐藏显示窗口==========================

;---Chromium---
^h:: toggleWin("- Google Chrome")

;---Kodi---
^1:: toggleWin("ahk_class Kodi")

;---VSDC Video Editor---
^4:: toggleWin("VSDC Video Editor")

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

;===============================有道词典=====================================

;---显示隐藏有道词典窗口---
^i::^!x
;<^Up::
;<^Down::^!x
;ControlGetFocus, Edit1, ahk_class YdMiniModeWndClassName
;return

;---有道词典标准窗口活动时下列快捷键有效---
#IfWinActive, ahk_class YodaoMainWndClass
    ^k::moveWindow("Up")
    ^j::moveWindow("Down")
    ^h::moveWindow("Left")
    ^l::moveWindow("Right")
    ^p::^v
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

