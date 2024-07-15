$param1 = Read-Host -Prompt "Entrer la valeur à remplacer "
$param2 = Read-Host -Prompt "Valeur modifier : "
Get-ChildItem -Path "C:\Users\Redacted\Bureau\Auto\A importer\Disponible\DK-719-GM" -Recurse -Include "*" | Rename-Item -NewName { $_.Name -replace "$param1","$param2" }