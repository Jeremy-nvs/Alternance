# Un script qui génere 10 dossier au nom aléatoire
$code = ""
$param =""
$lenght = 8
1..10 | ForEach-Object { 

$code = Get-Random -Minimum 5 -Maximum 1000
$param1 = $code
$param2 = $param + [char]$code.$lenght
New-Item -ItemType Directory -Path .\$param1\$param2\
Write-Host $param1 $param2
}
