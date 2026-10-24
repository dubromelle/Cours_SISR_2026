# creer-comptes-ad.ps1 : crée les comptes des membres des ligues dans m2l.lan
# Usage : .\creer-comptes-ad.ps1 -Fichier .\membres-ligues.csv [-Test]
param(
    [Parameter(Mandatory = $true)][string]$Fichier,
    [switch]$Test
)
Import-Module ActiveDirectory
$base    = "OU=Ligues,OU=M2L,DC=m2l,DC=lan"
$journal = "C:\Scripts\creation-comptes.log"
$crees = 0 ; $ignores = 0

function Get-Login([string]$Prenom, [string]$Nom) {
    $texte = ("$Prenom.$Nom").ToLower().Normalize([Text.NormalizationForm]::FormD)
    $texte = $texte -replace '\p{Mn}', '' -replace "[ ']", ''
    if ($texte.Length -gt 20) { $texte = $texte.Substring(0, 20) }
    return $texte
}

function New-MotDePasse {
    $caracteres = [char[]]('abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789')
    return "M2l!" + -join ($caracteres | Get-Random -Count 8)
}

if (-not (Test-Path $Fichier)) { Write-Error "Fichier introuvable : $Fichier" ; exit 1 }
$membres = Import-Csv -Path $Fichier -Delimiter ';' -Encoding UTF8

foreach ($m in $membres) {
    $login  = Get-Login $m.Prenom $m.Nom
    $ou     = "OU=$($m.Ligue),$base"
    $groupe = "GG_$($m.Ligue)"

    if (Get-ADUser -Filter "SamAccountName -eq '$login'") {
        Write-Output "IGNORÉ  $login existe déjà" ; $ignores++ ; continue
    }
    if ($Test) {
        Write-Output "TEST    $login ($($m.Fonction)) -> $ou, groupe $groupe" ; $crees++ ; continue
    }
    # OU et groupe de la ligue, s'ils n'existent pas encore
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$($m.Ligue)'" -SearchBase $base)) {
        New-ADOrganizationalUnit -Name $m.Ligue -Path $base
    }
    if (-not (Get-ADGroup -Filter "Name -eq '$groupe'")) {
        New-ADGroup -Name $groupe -GroupScope Global -GroupCategory Security -Path $ou
    }
    $mdp = New-MotDePasse
    New-ADUser -Name "$($m.Prenom) $($m.Nom)" -GivenName $m.Prenom -Surname $m.Nom `
        -SamAccountName $login -UserPrincipalName "$login@m2l.lan" `
        -Title $m.Fonction -Department $m.Ligue -Path $ou `
        -AccountPassword (ConvertTo-SecureString $mdp -AsPlainText -Force) `
        -ChangePasswordAtLogon $true -Enabled $true
    Add-ADGroupMember -Identity $groupe -Members $login
    Add-Content -Path $journal -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') CRÉÉ $login groupe=$groupe"
    Write-Output "CRÉÉ    $login -> $groupe, mot de passe provisoire : $mdp"
    $crees++
}
Write-Output "Bilan : $crees compte(s) traité(s), $ignores ignoré(s)."
