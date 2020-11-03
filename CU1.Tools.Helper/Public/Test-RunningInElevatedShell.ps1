function Test-RunningInElevatedShell {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    return $(New-Object Security.Principal.WindowsPrincipal $currentUser).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}