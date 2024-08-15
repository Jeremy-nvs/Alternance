Import-Module ActiveDirectory

$username = "NewUser"
$displayName = "New User"
$samAccountName = "NewUser"
$userPrincipalName = "NewUser@yourdomain.com"
$givenName = "First"
$surname = "Last"
$password = "P@sswOrd" | ConvertTo-SecureString -AsPlainText -Force

$SourceFiles = "C:\temp\listsofADUsers.xlsx"

function New-User-Activate-Change-Password {
    param(
        [string ]$username,
        [string ]$displayName,
        [string ]$samAccountName,
        [string ]$userPrincipalName,
        [string ]$givenName,
        [string]$surname,
        [SecureString ]$password
    )

    New-ADUser -SamAccountName $samAccountName -Name $displayName -GivenName $givenName -Surname $surname -DisplayName $displayName -UserPrincipalName $userPrincipalName -Enabled $true -AccountPassword $password -PassThru -ChangePasswordAtLogon $True

Write-Host "$username Ajouter"
}

New-User-Activate-Change-Password -username $username -displayName $displayName -samAccountName $samAccountName -UserPrincipalName $userPrincipalName -givenName $givenName -surname $surname -password $password
