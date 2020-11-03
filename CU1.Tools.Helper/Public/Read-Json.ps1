function Read-Json {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )

    return Get-Content -Path $Path -Raw | ConvertFrom-Json
}