# Persistence

*- maintaining access.*

## T1547 - Boots or Logon Autostart Execution

### T1547.001 - Registry Run Keys / Startup Folder

- Current user registry run key:
```ps1
$cmd = "$env:HOMEDRIVE\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\"
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\ -Name poc -PropertyType String -Value $cmd
```

- Current user startup folder:
```ps1
$cmd = "$env:HOMEDRIVE\Windows\explorer.exe $env:HOMEPATH\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
$cmds = $cmd -split ' ', 2 ; $lnk = (New-Object -ComObject WScript.Shell).CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\poc.lnk") ; $lnk.TargetPath = $cmds[0] ; $lnk.Arguments = $cmds[1] ; $lnk.Save()
```

## Resources

- [T1547](https://attack.mitre.org/techniques/T1547/)
    - [T1547.001](https://attack.mitre.org/techniques/T1547/001/)
