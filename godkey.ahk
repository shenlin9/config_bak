#SingleInstance force

DetectHiddenWindows, On
SetTitleMatchMode, 2
SetTitleMatchMode, Fast

;---��ݼ�---
; # Win
; ! Alt 
; ^ Control 
; + Shift 

;------���̼��ٰ��ƽ⣬�Զ��������ںͿ�ʼ����--------

;������ʵ����
Today = %A_YYYY%/%A_MM%/%A_DD%

;���������
Yesterday  = %A_Now%   ;����Ϊ YYYYMMDDHH24MISS ��ʽ����ʹ������ĺ���
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
    WinWait,���� - ���ٰ�
    Sleep,100
    Send {Click 650,123}
    Send {Click 1493,239}
    Send !{TAB}
    Sleep,70000

    IfWinExist,���� - ���ٰ�
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

;WheelUp::msgbox,�������Ϲ���
;WheelDown::msgbox,�������¹���

;�������
WheelLeft::^+TAB
WheelRight::^TAB

;MButton::msgbox,���ֵ��
MButton::
SoundGet, master_mute, , mute
SoundSet, +1, , mute
if (master_mute = "On")
{
    ;ϵͳ��������
    ;Run,%windir%\System32\SndVol.exe -f 49825268

    ;���½ǵ� thinkpad ��������
    ControlClick, x2145 y33, ahk_class Shell_TrayWnd
}
else
{
    SoundSet, 10
}
return

;XButton1::msgbox,�ļ����
;XButton2::msgbox,������
XButton1::
IfWinActive, ahk_class CabinetWClass
    Send {Backspace}
else
    Send ^w
return
;XButton2::Backspace
XButton2::^TAB
;XButton2::^+TAB

;---�� Win �����жԻ���---
;RWin:: #r
;^-::#e

;---�ر���ʾ��---
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
    RunWait, rundll32.exe user32.dll`,LockWorkStation    ; Ҫ���е�Ŀ��������ж�������뱻ת��
    Sleep,500
    SendMessage,0x112,0xF170,2,,Program Manager
} else {
    RunWait, %comspec% /c powercfg /X -standby-timeout-ac 60,,Hide
}
return

;SendMessage,0x112,0xF170,2,,Program Manager
            ;0x112��WM_SYSCOMMAND��
            ;0xF170��SC_MONITORPOWER��
                    ;2���رա�
                    ;1��activate thedisplay's "low power" mode��
                    ;-1��turn the monitor on

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
IfWinExist, Mozilla Firefox ����˽�����    ;ע�����ﲻҪ��˫���ţ������жϳ���
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

;---��ʾ�����е��ʵ����㴰��(�°汾�ʵ��ϳ���)---
<^Up::
<^Down::^!x
;ControlGetFocus, Edit1, ahk_class YdMiniModeWndClassName
;return

;---�е��ʵ��׼���ڻʱ���п�ݼ���Ч---
#IfWinActive, ahk_class YodaoMainWndClass
    Up::moveWindow("Up")
    Down::moveWindow("Down")
    Left::moveWindow("Left")
    Right::moveWindow("Right")
    /::^!v
#IfWinActive

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

;---�е��ʵ仮�ʴ��ڻʱ���п�ݼ���Ч---
#IfWinActive, YoudaoStrokeWnd
    ;---����/ɾ�����ʱ�---
    d::^!s
#IfWinActive

;---�ƶ����ں���---
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

    ;�ƶ����ʲ�ѯ���ݴ���
    WinMove, ahk_class YdMiniCefWnd, , x, y + Height
}

;
; ----------------------------------------------------------------------------
;

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
