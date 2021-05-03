#Persistent
#SingleInstance force

FileEncoding, UTF-8
DetectHiddenWindows, On
SetTitleMatchMode, 2
SetTitleMatchMode, Fast

; ---功能键含义---
;  # Win
;  ! Alt 
;  ^ Control 
;  + Shift 
;  ~ 前缀，不屏蔽热键本身的功能

; ===============================移动窗口=======================================

#If WinActive("ahk_exe Everything.exe")
or WinActive("ahk_exe eudic.exe")
or WinActive("ahk_class Notepad")
    ^k::moveWindow("Up")
    ^j::moveWindow("Down")
    ^h::moveWindow("Left")
    ^l::moveWindow("Right")
#IfWinActive

; ======================按键重映射==========================

; ---Ctrl + Capslock 触发大写---
^Capslock::Capslock

; ---Capslock 映射为　ESC---
Capslock::ESC

; ---RControl, RAlt  互换---
;RControl::RAlt
;RAlt::RControl

;调用 listary
RWin::^+=
AppsKey::^+=

; --左 Ctrl+单引号映射为 Alt+Tab
<^'::!Tab

; --左 Ctrl+分号映射为 Alt+ESC
<^;::!ESC

; --- Navigation ---
#If not WinActive("ahk_exe gvim.exe")
    ; 使用 ctrl+n ctrl+p 映射选项卡切换键
    ^p::Send, {Control Down}{Shift Down}{Tab}{Shift Up}{Ctrl Up}
    ^n::Send, {Control Down}{Tab}{Ctrl Up}

    ; 关闭选项卡
    ;Capslock::^w

    ; 使用 ctrl+j ctrl+k 代替上下方向键
    ^j::Send {Down}
    ^k::Send {Up}
    ^h::Send {Left}
    ^l::Send {Right}

    ; 使用 ctrl+, ctrl+. 代替home, end键
    ^,::Send {Home}
    ^.::Send {End}
#IfWinActive

; ================退出时关闭蓝牙、静音=================
OnExit("ExitFunc")

ExitFunc(ExitReason, ExitCode)
{
    if ExitReason in Logoff,Shutdown
    {
        Run, %comspec% /c powershell -command D:\git-repo\config_bak\godkey\bluetooth.ps1 -BluetoothStatus Off,,Hide
        Send,{Volume_Mute}
        return 0  ; OnExit 函数返回非零值则不退出.
    }
    ; 不要调用 ExitApp -- 那会阻止其他 OnExit 函数被调用.
}

; ================创建内存盘文件夹=================
Run, %comspec% /c mkdir "z:\TEMP" "z:\Chrome" "z:\Download" "z:\FireFox" "z:\INetCache" "z:\360 Browser",,Hide

; ================关闭蓝牙=================
;Sleep, 500
;Run, %comspec% /c powershell -command D:\git-repo\config_bak\godkey\bluetooth.ps1 -BluetoothStatus Off,,Hide

; ================静音=================
;Send,{Volume_Mute}

; ===================== 快速查看、禁用、启用 IE 代理 ==========================

; ------代理服务器--------
Sleep, 500
UpdateIconLight()

; ------定期读取代理状态--------
;SetTimer, UpdateIconLight, 5000

; ------根据当前代理状态更改托盘图标和ScrollLock键灯光--------
UpdateIconLight() {
    OutputVar := ReadProxy()
    if (OutputVar = 1){
        SetTrayIcon(true)
        SetScrollLockState, On
    } else {
        SetTrayIcon(false)
        SetScrollLockState, Off
    }
}

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
SetTrayIcon(UseAgent) {
    if (UseAgent) {
        Menu, Tray, Icon, ProxyLink.ico
    } else {
        Menu, Tray, Icon, DirectLink.ico
    }
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
    SetProxy("127.0.0.1:1088")
    SetTrayIcon(true)
} else {
    SetProxy("")
    SetTrayIcon(false)
}
return

; ------快捷键查看代理状态--------
F8::
Run,rundll32.exe shell32.dll`, Control_RunDLL inetcpl.cpl`, `,4L
Sleep,200
Send !l
return

; ------快捷键更改路由，使用有线网卡还是无线网卡上网--------
Route := "LAN"

F9::
if ( Route = "WLAN" ) {
    Run, %comspec% /c route delete 0.0.0.0 mask 0.0.0.0 192.168.124.1 & route delete 10.63.160.1 mask 255.255.255.255 192.168.123.1 & route add 0.0.0.0 mask 0.0.0.0 192.168.123.1,,Hide
    ; Menu, Tray, Tip, "LAN"
    Route := "LAN"
} else {
    Run, %comspec% /c route delete 0.0.0.0 mask 0.0.0.0 192.168.123.1 & route add 10.63.160.1 mask 255.255.255.255 192.168.123.1 & route add 0.0.0.0 mask 0.0.0.0 192.168.124.1,,Hide
    ; Menu, Tray, Tip, "Wireless"
    Route := "WLAN"
}
return

; ========================按一次关闭显示器，连按两次系统睡眠===================
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
if winc_presses = 1 ;  此键按下了1次.
{
    ;  关闭显示器
    SendMessage,0x112,0xF170,2,,Program Manager
}
else if winc_presses >= 2 ;  此键按下至少2次.
{
    Run, psshutdown.exe -d -t 0, ,Hide
}
;  不论触发了上面的哪个动作, 都对 count 进行重置
;  为下一个系列的按下做准备:
winc_presses = 0
return


; ======================TotalCmd==========================

#IfWinActive, ahk_class TTOTAL_CMD
    ; 右键菜单
    ^l::MouseClick, right
    ; 查看属性
    ^.::send !{Enter}
#IfWinActive

; ======================PotPlayer截屏快捷键==========================

#IfWinActive, ahk_class PotPlayer64
    ,::^!e
#IfWinActive

; ======================鼠标快捷键==========================

#If WinActive("ahk_class Chrome_WidgetWin_1")
or WinActive("ahk_class MozillaWindowClass")
    XButton1::^w
    ;XButton2::msgbox,5
#IfWinActive

; ===============================数字快捷键=====================================

;--- xxx ---
;^1:: toggleWin("")

;--- xxx ---
;^2:: toggleWin("")

; --- Video Editor ---
;^3:: toggleWin("")

;--- xxx ---
;^4:: toggleWin("")

;--- xxx ---
;^5:: toggleWin("")

; ---Everything---
^6::^!0

;---Total Commander---
^7:: toggleWin("ahk_class TTOTAL_CMD")

; ---Photoshop---
^8:: toggleWin("ahk_class Photoshop")

;--- xxx ---
;^9::
;toggleWin("ahk_class VIDEOEDITOR")
;toggleWin("TechSmith Camtasia")
;toggleWin("ahk_class Premiere Pro")
;return

;--- xxx ---
;^0:: toggleWin("")

; ===============================字母快捷键=====================================

; ---Chromium---
^o:: toggleWin("Google Chrome")

; ---firefox, Tor---
^u::
toggleWin("Mozilla Firefox") 
toggleWin("Tor") 
return

; 隐藏任务栏
;^-:: toggleWin("ahk_class Shell_TrayWnd")

; ---背景白噪音---
;^\:: toggleWin("rain.m4a")

; ---ChinaDNS---
;^\:: toggleWin("dnsrelay.exe")

; ---蓝牙---
^\:: Run, %comspec% /c powershell -command D:\git-repo\config_bak\godkey\bluetooth.ps1 -BluetoothStatus On,,Hide

; 退出脚本
;~lbutton & enter::
;exitapp


; ===============================欧陆词典=====================================

^i::
Send ^!j
IfWinActive, ahk_exe eudic.exe
{
    Clipboard := StrReplace(Clipboard, "`r`n", A_Space)
    Clipboard := StrReplace(Clipboard, "`n", A_Space)
    Send {BackSpace}^v{Enter}
}
return

#IfWinActive, ahk_exe eudic.exe
; 使用单引号直接粘贴剪贴板内容查询
':: Send {BackSpace}^v{Enter}
; 朗读发音
/::^!s
; 滚动条
,::PgUp
.::PgDn
#IfWinActive

; ===============================GoldenDict=====================================

;^i::
;Send ^!+j
;IfWinActive, ahk_exe GoldenDict.exe
;{
;    Clipboard := StrReplace(Clipboard, "`r`n", A_Space)
;    Clipboard := StrReplace(Clipboard, "`n", A_Space)
;    Send {BackSpace}^v{Enter}
;}
;return

;#IfWinActive, ahk_exe GoldenDict.exe
;; 使用单引号直接粘贴剪贴板内容查询
;~':: Send {BackSpace}^v{Enter}
;; 朗读发音
;/::!s
;; 滚动条
;,::PgUp
;.::PgDn
;#IfWinActive

; ===============================有道词典=====================================

; ---有道词典---
;^i::^!x

; ---有道词典标准窗口活动时下列快捷键有效---
;#IfWinActive, ahk_class YodaoMainWndClass
;    ^p::^v
;    /::^!v
;    ,::^Left
;    .::^Right
;#IfWinActive

; ---有道词典划词窗口活动时下列快捷键有效---
;#IfWinActive, YoudaoStrokeWnd
    ; ---加入/删除生词本---
    ;d::^!s
;#IfWinActive

; ===============================沙拉查词=======================================

;#IfWinActive, ahk_class Chrome_WidgetWin_1
    ;Capslock::^w
    ;WinGetTitle, Title, A
    ;; 中文"沙拉查词"提示非法字符
    ;if ("沙拉查词" in %Title%) {
    ;    msgbox,aaa
    ;    Send, ^w
    ;}
;#IfWinActive

; ===============================切换Tab=======================================

;#If WinActive("ahk_class ATLWIN_JISUPDF_MIAN")
;or WinActive("ahk_class TTOTAL_CMD")
;or WinActive("ahk_class Chrome_WidgetWin_1")
;or WinActive("ahk_class MozillaWindowClass")
;or WinActive("ahk_class AcrobatSDIWindow")
;    ^p::Send, {Control Down}{Shift Down}{Tab}{Shift Up}{Ctrl Up}
;    ^n::Send, {Control Down}{Tab}{Ctrl Up}
;#IfWinActive

; ===============================移动窗口函数===================================

moveWindow(Direct)
{
    WinGet,WinID,ID,A

    WinGetPos, x, y, Width, Height, ahk_id %WinID%
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

    WinMove, ahk_id %WinID%, , %x%, %y%

    return
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

    return
}

; ===============================系统托盘处使用鼠标滚轮调整音量================

~WheelUp::
if (existclass("ahk_class Shell_TrayWnd")=1)
    Send,{Volume_Up}
Return

~WheelDown::
if (existclass("ahk_class Shell_TrayWnd")=1)
    Send,{Volume_Down}
Return

~MButton::
if (existclass("ahk_class Shell_TrayWnd")=1)
    Send,{Volume_Mute}
Return

existclass(class)
{
    MouseGetPos,x,y,win

    WinGet,winid,id,%class%
    if win = %winid%
        if x > 2280
            Return,1
        else
            Return,0
    Else
        Return,0
}

;---遍历窗口----
;^9::show_all_win()

show_all_win()
{
    DetectHiddenWindows, Off
    WinGet, id, List,,, Program Manager
    Loop, %id%
    {
        this_id := id%A_Index%
        WinActivate, ahk_id %this_id%
        WinGetClass, this_class, ahk_id %this_id%
        WinGetTitle, this_title, ahk_id %this_id%
        MsgBox, 4, , Visiting All Windows`n%A_Index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
        IfMsgBox, NO, break
    }
}

