﻿; Generated by Auto-GUI 3.0.1
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
FirstTime := true
isWorking := false
StreamingContinue := false
Menu, Tray, Icon, %A_ScriptDir%\source\icon.ico

Gui Font, s9, Segoe UI
Gui Font
Gui Font, s10
Gui Add, Text, x8 y0 w207 h29 +0x200, LiveCheck v1.0 By Dormant1337
Gui Font
Gui Font, s9, Segoe UI
Gui Add, Picture, x216 y0 w32 h32 gGithubLink, D:\Desktop\AutoHotKey\testing\source\github.png
Gui Font
Gui Font, s9, Segoe UI
Gui Add, Text, x8 y25 w66 h23 +0x200, Paste link:
Gui Font
Gui Font, s9, Segoe UI
Gui Add, Edit, x64 y26 w143 h21 vTwitchLink
Gui Add, Button, x72 y80 w100 h30 gActivateButton vActivateButton, Activate
Gui Add, CheckBox, x8 y51 w120 h18 vSoundNotify, Sound notification

Gui Show, w258 h140, LiveCheck v1.0 By Dormant1337
Return

GithubLink:
Run, https://github.com/Zer0Flux86/Twitch-LiveChecker
return

ActivateButton:
if(FirstTime) {
    SetTimer, StreamChecker, 3000
    FirstTime := false
}
if(isWorking) {
    isWorking := false
    GuiControl,, ActivateButton, Activate
} else {
    isWorking := True
    GuiControl,, ActivateButton, Deactivate
}
return

StreamChecker:
if(isWorking) {
    GuiControlGet, SoundNotify, , SoundNotify
    StreamerUrl := TwitchLink
    IsLive := CheckTwitchLive(StreamerUrl)
    if(IsLive && !StreamingContinue) {
        if(SoundNotify) {
            SoundPlay, %A_ScriptDir%\source\StreamIsLive.mp3
        } else {
            TrayTip, Stream is live!, %StreamerUrl% is live!
        }
        StreamingContinue := true
    } else if(!IsLive) {
        StreamingContinue := false
    }
}


CheckTwitchLive(StreamerUrl)
{
    ; Скачиваем HTML-страницу стримера
    UrlDownloadToFile, %StreamerUrl%, temp.html

    ; Читаем содержимое файла
    FileRead, HtmlContent, temp.html

    ; Проверяем на индикатор прямого эфира
    if InStr(HtmlContent, "isLiveBroadcast")
    {
        return true
    }
    else
    { 
        return false
    }

    ; Удаляем временный файл
    FileDelete, temp.html
}

