function Split-cu1StoredProceduresFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $InputFile,

        [Parameter(Mandatory = $true)]
        [string]
        $OutputPath
    )

    if (-not (Test-Path -Path $OutputPath)) {
        New-Item $OutputPath -ItemType Directory
    }

    $i = 0
    foreach ($line in Get-Content $inputfile) {
        if ($line.contains('/****** Object:  StoredProcedure ')) {
            if ($i -gt 0) {
                Write-Host "New File: $(Join-Path $OutputPath -ChildPath $OutputFileName)"
                Set-Content `
                    -Path $(Join-Path $OutputPath -ChildPath $OutputFileName) `
                    -Value $OutputFileContent
            }
            $i++

            $OutputFileName = "$($line.Substring(50,$line.IndexOf(']    Script Date: ')-50)).sql"

            $OutputFileContent += $Null
            $OutputFileContent = ($line + "`r`n")
        }
        else {
            $OutputFileContent += ($line + "`r`n")
        }
    }

    Write-Host "New File: $(Join-Path $OutputPath -ChildPath $OutputFileName)"
    Set-Content `
        -Path $(Join-Path $OutputPath -ChildPath $OutputFileName) `
        -Value $OutputFileContent
}