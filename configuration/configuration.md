# Configuration

*- ?.*

## System

### Theme

1. Use dark theme:
    ```ps1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /F /V AppsUseLightTheme /T REG_DWORD /D 0
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /F /V SystemUsesLightTheme /T REG_DWORD /D 0
    TASKKILL /F /IM explorer.exe ; explorer.exe
    ```

### Startup Programs

1. Remove autostart programs:
    ```ps1
    REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Run /F /VA
    ```

## System Apps

### Explorer.exe

1. Show file extensions and all hidden files:
    ```ps1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V Hidden /T REG_DWORD /D 1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V HideFileExt /T REG_DWORD /D 0
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V ShowSuperHidden /T REG_DWORD /D 1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /F /V UseCompactMode /T REG_DWORD /D 1
    TASKKILL /F /IM explorer.exe ; explorer.exe
    ```

### Regedit.exe

1. Add registries to favorites for quick access:
    ```ps1
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites /F /V Run /T REG_SZ /D Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
    ```

## 3rd Party Apps

### Scoop

1. Install Scoop package manager:
    ```ps1
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass ; Invoke-WebRequest -UseBasicParsing get.scoop.sh | Invoke-Expression
    ```
