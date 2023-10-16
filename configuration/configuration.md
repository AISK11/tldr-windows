# Configuration

*- user configuration.*

## System

### Personalize

1. Clear desktop:
    ```ps1
    Remove-Item -Recurse -Force -Path $env:USERPROFILE\Desktop\*
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /F /V '{645FF040-5081-101B-9F08-00AA002F954E}' /T REG_DWORD /D 1
    TASKKILL /F /IM explorer.exe /FI "USERNAME eq $(WHOAMI)" ; explorer.exe
    ```
2. Clear taskbar:
    ```ps1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V TaskbarAl /T REG_DWORD /D 0
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V TaskbarDa /T REG_DWORD /D 0
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V ShowTaskViewButton /T REG_DWORD /D 0
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V TaskbarMn /T REG_DWORD /D 0
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Search /F /V SearchboxTaskbarMode /T REG_DWORD /D 0
    REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /F /VA
    TASKKILL /F /IM explorer.exe /FI "USERNAME eq $(WHOAMI)" ; explorer.exe
    ```
3. Use dark theme:
    ```ps1
    TASKKILL /F /IM SystemSettings.exe /FI "USERNAME eq $(WHOAMI)" ; Start-Process -FilePath $env:SystemRoot\Resources\Themes\themeA.theme ; do { TASKLIST /FO CSV /NH /FI 'IMAGENAME eq SystemSettings.exe' /FI "USERNAME eq $(WHOAMI)" | FINDSTR /IM SystemSettings.exe } while ($? -eq $False) ; TASKKILL /F /IM SystemSettings.exe /FI "USERNAME eq $(WHOAMI)"
    ```

### Debloat

1. Remove autostarting programs:
    ```ps1
    REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Run /F /VA
    Remove-Item -Force -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\*"
    ```

### Install

---

## System Apps

### Explorer.exe

1. Show file extensions and all hidden files:
    ```ps1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V Hidden /T REG_DWORD /D 1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V HideFileExt /T REG_DWORD /D 0
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V ShowSuperHidden /T REG_DWORD /D 1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V UseCompactMode /T REG_DWORD /D 1
    ```

### Regedit.exe

1. Add registries to favorites for quick access:
    ```ps1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites /F /V Run /T REG_SZ /D Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
    ```

## 3rd Party Apps

### Scoop

1. Install [Scoop](https://scoop.sh) package manager:
    ```ps1
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force ; Invoke-WebRequest -UseBasicParsing get.scoop.sh | Invoke-Expression
    ```
