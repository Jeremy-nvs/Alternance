$year1 = Read-Host -Prompt "Entrer la valeur à remplacer "
$yearshort = Read-Host -Prompt "Valeur modifier : "
Get-ChildItem -Path "C:\Users\Redacted\OneDrive - MyReport\Bureau\Auto\" -Recurse -Include "*.pdf" | Rename-Item -NewName { $_.Name -replace "$year1","$yearshort" }