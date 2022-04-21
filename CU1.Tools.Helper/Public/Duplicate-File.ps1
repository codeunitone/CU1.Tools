function Duplicate-File {
    <#
    .SYNOPSIS
        Creates a duplicate of a specified file

    .DESCRIPTION
        Creates a duplicate of the specified file by sufixing the filename with _dup.
        The duplicated file will be created in the same folder then the source file.
        If the destination file already exists, the user is asked if the file should be overwritten.

    .PARAMETER Path
        Defines the path to file which will get duplicated


    .EXAMPLE
        PS C:\> Duplicate-cu1File -Path .\HelloWorld.txt

        Creates a copy of the file in the same directory with the name 'HelloWorld_dup.txt'.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )

    $SourceFile = Get-Item -Path $Path

    $TargetFile = @{
        BaseName      = $SourceFile.BaseName + '_dup'
        Name          = $SourceFile.BaseName + '_dup' + $SourceFile.Extension
        DirectoryName = $SourceFile.DirectoryName
        Fullname      = $(Join-Path -Path $SourceFile.DirectoryName -ChildPath $($SourceFile.BaseName + '_dup' + $SourceFile.Extension))
    }

    if (Test-Path $TargetFile.FullName) {
        Write-Warning "$($TargetFile.FullName) already exist."
        $Answer = Read-Host 'Do you want to overwrite that file? [y/n]'
        if (-not ($Answer -eq 'y')) {
            Write-Error 'abort'
        }

    }

    Copy-Item `
        -Path $SourceFile.FullName `
        -Destination $TargetFile.FullName
}