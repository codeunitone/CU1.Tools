function Update-cu1FeatureBranch {
	param (
		[string]
		$GitRepoFolder,

		[Parameter(Mandatory = $true)]
		[string]
		$SourceBranch
	)

	$ErrorActionPreference = "Stop"

	if ($GitRepoFolder -eq '') {
		$GitRepoFolder = Get-Location
	}

	$FeatureBranch = git -C $GitRepoFolder rev-parse --abbrev-ref HEAD
	Write-Host ('Checkout {0}' -f $SourceBranch) -ForegroundColor Cyan
	git -C $GitRepoFolder checkout $SourceBranch
	Write-Host ('Update {0}' -f $SourceBranch) -ForegroundColor Cyan
	git -C $GitRepoFolder pull --rebase
	Write-Host ('Checkout {0}' -f $FeatureBranch) -ForegroundColor Cyan
	git -C $GitRepoFolder checkout $FeatureBranch
	Write-Host ('Merge {0}' -f $SourceBranch) -ForegroundColor Cyan
	git -C $GitRepoFolder merge $SourceBranch
}