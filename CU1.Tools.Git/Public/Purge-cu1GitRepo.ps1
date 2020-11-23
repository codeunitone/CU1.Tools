function Purge-cu1GitRepo {
    $ErrorActionPreference = "Stop"

    git reset;
    git clean -df;
    git checkout -- .
}