#Persistent
#SingleInstance force

DetectHiddenWindows, On
SetTitleMatchMode, 2
SetTitleMatchMode, Fast

; ---功能键含义---
;  # Win
;  ! Alt 
;  ^ Control 
;  + Shift 

; ==============程序加载时根据当前代理状态更改图标===========
ServerAddr := "127.0.0.1:1088"

OutputVar := ReadProxy()
if (OutputVar = 1){
    SetTrayIcon(ServerAddr)
    SetScrollLockState, On
} else {
    SetTrayIcon("")
    SetScrollLockState, Off
}

; ================创建内存盘文件夹=================
Run, %comspec% /c mkdir "z:\TEMP" "z:\Chrome" "z:\Download" "z:\FireFox" "z:\INetCache" "z:\360 Browser",,Hide

; ================速盘急速版破解，自动更改日期和开始下载=================

; ------今天实际日期--------
Today = %A_YYYY%/%A_MM%/%A_DD%

; ------昨天的日期--------
Yesterday  = %A_Now%   ; 必须为 YYYYMMDDHH24MISS 格式才能使用下面的函数
EnvAdd, Yesterday, -1, days
FormatTime, Yesterday, %Yesterday%, ShortDate

TheDate = %Today%

; ------设置系统日期--------
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

; ------启动程序自动开始下载--------
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

;^\::DownLoad()

; =====================快速查看、禁用、启用 IE 代理==============================

; ------读取 IE 代理--------
ReadProxy() {
    ; RegRead, OutputVar, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\, ProxyEnable
    RegRead, OutputVar, HKEY_USERS\S-1-5-21-2649311137-1019525462-828708016-1001\Software\Microsoft\Windows\CurrentVersion\Internet Settings, ProxyEnable
    Return OutputVar
}

; ------设置 IE 代理--------
SetProxy(Server) {
    Run, SetProxy.exe "%Server%", , Hide, OutputVarPID
}

; ------设置托盘图标--------
SetTrayIcon(Server) {
    if (Server = "") {
        Menu, Tray, Icon, DirectLink.ico
        Menu, Tray, Tip , Direct Link
    } else {
        Menu, Tray, Icon, ProxyLink.ico
        Menu, Tray, Tip , Proxy Server : %Server%
    }
    ; Menu, Tray, NoIcon     ;  隐藏托盘图标
    ; Menu, Tray, Icon        ;  显示托盘图标
}

; ------快捷键切换代理状态--------
;  Wait for it to be released because otherwise the hook state gets reset
;  while the key is down, which causes the up-event to get suppressed,
;  which in turn prevents toggling of the ScrollLock state/light:
~ScrollLock::
KeyWait, ScrollLock
GetKeyState, ScrollLockState, ScrollLock, T
If ScrollLockState = D
{
    SetProxy(ServerAddr)
    SetTrayIcon(ServerAddr)
} else {
    SetProxy("")
    SetTrayIcon("")
}
return

; ------快捷键查看代理状态--------
F8::
Run,rundll32.exe shell32.dll`, Control_RunDLL inetcpl.cpl`, `,4L
Sleep,200
Send !l
return

; ========================系统睡眠========================
Pause::
;  检测热键的单次, 两次和三次按下. 这样允许热键根据您按下次数的多少
;  执行不同的操作：
if winc_presses > 0 ;  SetTimer 已经启动, 所以我们记录键击.
{
    winc_presses += 1
    return
}
;  否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器：
winc_presses = 1
SetTimer, KeyWinC, 300 ;  在 300 毫秒内等待更多的键击.
return

KeyWinC:
SetTimer, KeyWinC, off
if winc_presses = 1 ;  此键按下了一次.
{
    ;  关闭显示器
    SendMessage,0x112,0xF170,2,,Program Manager
}
else if winc_presses >= 2 ;  此键按下至少三次.
{
    ;  3 秒后休眠
    Sleep, 3000
    Run, psshutdown.exe -d -t 0, ,Hide
}
;  不论触发了上面的哪个动作, 都对 count 进行重置
;  为下一个系列的按下做准备:
winc_presses = 0
return

; ======================按键重映射==========================

; ---Capslock和ESC互换---
Capslock::ESC
ESC::Capslock

; ---右 Win 键运行对话框---
RWin::#r

; --左 Ctrl+单引号映射为 Alt+Tab
<^'::AltTab

; --左 Ctrl+分号映射为 Alt+ESC
<^;::!ESC

; ======================TotalCmd==========================

#IfWinActive, ahk_class TTOTAL_CMD
    ; 右键菜单
    '::Appskey
    ; 直接映射为 Up，Down 失败，这种方式可以
    ^j::Send {Down}
    ^k::Send {Up}
#IfWinActive

; ======================PotPlayer截屏快捷键==========================

#IfWinActive, ahk_class PotPlayer64
    ,::^!e
#IfWinActive

; ======================隐藏显示窗口==========================

; ---背景白噪音---
;^\:: toggleWin("rain.m4a")

; ---ChinaDNS---
;^\:: toggleWin("dnsrelay.exe")

; ---Chromium---
^h:: toggleWin("Google Chrome")

; ---Everything---
^1::^!0

; ---firefox---
^2:: toggleWin("Mozilla Firefox") 

; ---Movavi Video Editor---
^3:: toggleWin("Movavi Video Editor")

;---Total Commander---
^4:: toggleWin("ahk_class TTOTAL_CMD")

; ---GoldenDict---
^i::^!+j

; ---有道词典---
;^i::^!x

; ===============================有道词典=====================================


; ---有道词典标准窗口活动时下列快捷键有效---
#IfWinActive, ahk_class YodaoMainWndClass
    ^p::^v
    /::^!v
    ,::^Left
    .::^Right

    ; 移动单词查询内容窗口
    ;WinMove, ahk_class YdMiniCefWnd, , x, y + Height
#IfWinActive

; ---有道词典划词窗口活动时下列快捷键有效---
#IfWinActive, YoudaoStrokeWnd
    ; ---加入/删除生词本---
    d::^!s
#IfWinActive

; ===============================移动窗口=======================================
#If WinActive("ahk_exe Everything.exe")
or WinActive("ahk_exe GoldenDict.exe")
or WinActive("ahk_class YodaoMainWndClass")
    Up::
    ^k::moveWindow("Up")
    Down::
    ^j::moveWindow("Down")
    Left::
    ^h::moveWindow("Left")
    Right::
    ^l::moveWindow("Right")
return

; ===============================移动窗口函数===================================
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

}

; ===============================隐藏显示窗口===================================
toggleWin(win_title)
{
    IfWinNotExist, %win_title%
        return 0

    IfWinActive
    {
        ;WinHide
        ;WinMinimize
        WinHide
        Send !{ESC}
        return -1
    }
    else
    {
        ;WinMaximize
        WinShow
        WinActivate
        return 1
    }
}
