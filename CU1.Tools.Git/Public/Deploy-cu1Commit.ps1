function Deploy-cu1Commit {
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $TargetBranch,

        [Parameter(Mandatory = $true)]
        [string[]]
        $CommitHashes
    )

    git checkout $TargetBranch;
    git pull --rebase

    foreach ($Commit in $CommitHashes) {
        Write-Host "Cherry picking commit $Commit" -ForegroundColor Yellow
        git cherry-pick $Commit
    }
}