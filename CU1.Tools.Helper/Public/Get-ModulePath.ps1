function Get-ModulePath {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Modulename
    )

    return Split-Path (Get-Module $Modulename).Path
}