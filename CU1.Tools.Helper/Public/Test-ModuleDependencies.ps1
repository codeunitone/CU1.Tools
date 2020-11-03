function Test-ModuleDependencies {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]
        $Modules
    )

    foreach ($Module in $Modules) {
        if (!(Get-Module -Name ('{0}' -f $Module))) {
            throw 'Module {0} needs to be loaded first.' -f $Module
        }
    }
}