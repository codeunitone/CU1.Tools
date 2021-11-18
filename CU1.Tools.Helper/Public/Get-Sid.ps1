function Get-Sid {
    param (
        # define the username
        $UserName
    )

    # getting sid
    $objUser = New-Object System.Security.Principal.NTAccount($UserName)
    $strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])

    # show sid
    "The SID for $UserName ..."
    $strSID.Value

}