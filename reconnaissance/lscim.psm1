function lscim {
    param(
        [string]$class = '*',
        [string]$property = '*',
        [switch]$help = $false
    )
    if ($help) {
        Write-Output 'NAME'
        Write-Output '    lscim - list Component Information Model (CIM) classes, properties and values'
        Write-Output ''
        Write-Output 'SYNOPSIS'
        Write-Output '    lscim [-c CLASS [-p PROPERTY]]'
        Write-Output ''
        Write-Output 'DESCRIPTION'
        Write-Output '    -c CLASS    = CIM class.'
        Write-Output '    -p PROPERTY = CIM property.'
        Write-Output ''
        Write-Output 'EXAMPLES'
        Write-Output '    Show all classes:'
        Write-Output '        > lscim'
        Write-Output '    Show all Win32_ComputerSystem class properties:'
        Write-Output '        > lscim -c Win32_OperatingSystem'
        Write-Output '    Show HypervisorPresent property value of Win32_ComputerSystem class:'
        Write-Host -NoNewline '        > lscim -c Win32_ComputerSystem -p HypervisorPresent'
        return ''
    }
    if ($class -eq '*') {
        $class = (Get-CimClass -ClassName $class).CimClassName
        return "$class" -replace ' ', "`r`n"
    } elseif ($property -eq '*') {
        $property = (Get-CimClass -ClassName $class).CimClassProperties.Name
        return "$property" -replace ' ', "`r`n"
    }
    $value = (Get-CimInstance -ClassName $class).$property
    return "$value"
}
