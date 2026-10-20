# Sauvegarde de l'etat du site Simon Bourrat
# Usage:  .\sauvegarder.ps1 "description du changement"
#
# Enregistre toutes les modifications en cours et cree un point de
# restauration (commit) avec un message lisible.

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Message
)

$ErrorActionPreference = "Stop"
$site = $PSScriptRoot

Write-Host "=== Fichiers modifies ===" -ForegroundColor Cyan
$status = & wsl -d Ubuntu -- bash -c "cd '/mnt/c/Users/ghorg/Documents/Sites/Simon Bourrat' && git status --short"
if (-not $status) {
    Write-Host "Aucune modification a sauvegarder. Le site est deja a jour." -ForegroundColor Yellow
    exit 0
}
$status | ForEach-Object { Write-Host "  $_" }

Write-Host ""
& wsl -d Ubuntu -- bash -c "cd '/mnt/c/Users/ghorg/Documents/Sites/Simon Bourrat' && git add -A && git commit -m '$Message' > /dev/null 2>&1"

if ($LASTEXITCODE -eq 0) {
    Write-Host "=== Sauvegarde OK ===" -ForegroundColor Green
    $last = & wsl -d Ubuntu -- bash -c "cd '/mnt/c/Users/ghorg/Documents/Sites/Simon Bourrat' && git log --oneline -1"
    Write-Host "Point de restauration: $last"
    Write-Host ""
    Write-Host "=== Historique des sauvegardes ===" -ForegroundColor Cyan
    & wsl -d Ubuntu -- bash -c "cd '/mnt/c/Users/ghorg/Documents/Sites/Simon Bourrat' && git log --oneline -10"
} else {
    Write-Host "ERREUR: la sauvegarde a echoue." -ForegroundColor Red
    exit 1
}
