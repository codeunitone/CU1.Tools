function New-Module {
    param(
        [Parameter(Mandatory = $true)]
        [string]
        $ModuleName,

        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )

    $ErrorActionPreference = "Stop"

    # Load Settings
    $Cu1ToolsPowerShellModulePath = Get-cu1ModulePath -ModuleName 'CU1.Tools.PowerShell'
    $DefaultValues = Read-cu1json -Path $(Join-Path $Cu1ToolsPowerShellModulePath -ChildPath 'config\defaults.json')

    $ModulePath = Join-Path $Path -ChildPath $ModuleName
    if (!(Test-Path $ModulePath)) {
        New-Item -ItemType Directory -Path $ModulePath
    }

    # create manifest
    New-ModuleManifest `
        -Path $(Join-Path $ModulePath -ChildPath $("$ModuleName.psd1")) `
        -RootModule $(".\$ModuleName.psm1") `
        -Author $DefaultValues.Author `
        -CompanyName $DefaultValues.Company `
        -DefaultCommandPrefix $DefaultValues.DefaultCommandPrefix;

    # Create module file
    $psm1Content = @(
        'foreach ($file in $(Get-ChildItem -Path $(Join-Path $PSScriptRoot -ChildPath ''.\Public'') -Recurse -Filter ''*.ps1'')) {'
        '	. $file.fullname'
        '}'
    )
    Set-Content -Path $(Join-Path $ModulePath -ChildPath $("$ModuleName.psm1")) -Value $psm1Content

    # Create README
    Set-Content -Path $(Join-Path $ModulePath -ChildPath "README.md") -Value ('# {0}' -f $ModuleName)

    # Create Folder
    foreach ($Folder in @('Public', 'Private', 'config')) {
        $FolderToCreate = Join-Path $ModulePath -ChildPath $Folder
        if (!(Test-Path $FolderToCreate)) {
            New-Item -ItemType Directory -Path $FolderToCreate
        }
    }
}