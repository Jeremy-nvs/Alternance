$EnrollName = Get-ChildItem -Path "$env:WINDIR\System32\Tasks\Microsoft\Windows\EnterpriseMgmt\" -name

#Suppression des Tâches récurrentes

Get-ScheduledTask | Where-Object { $_.Taskpath -match $EnrollName } | Unregister-ScheduledTask -Confirm:$false
                    # delete also parent folder
                    Remove-Item -Path "$env:WINDIR\System32\Tasks\Microsoft\Windows\EnterpriseMgmt\$EnrollName" -Force
#Suppression des clé de registre associées

Remove-Item -Path HKLM:\SOFTWARE\Microsoft\Enrollments\$EnrollName -Force -Verbose -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\Enrollments\Status\$EnrollName -Force -Verbose -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\EnterpriseResourceManager\Tracked\$EnrollName -Force -Verbose -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\AdmxInstalled\$EnrollName -Force -Verbose -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\PolicyManager\providers\$EnrollName -Force -Verbose -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\$EnrollName -Force -Verbose -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\Provisioning\OMADM\Logger\$EnrollName -Force -Verbose -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\Provisioning\OMADM\Sessions\$EnrollName -Force -Verbose -Recurse

#Suppression du Certificat MDM

Get-ChildItem Cert:\LocalMachine\My\ | Where-Object {$_.Issuer -match 'Microsoft Intune MDM Device CA' } | Remove-Item

#Création du dossier ForensIT sur la machine cliente

New-Item -ItemType Directory -Path C:\ProgramData\ForensiT\Migrate

# Copie de l'exe de migration sur la machine Cliente

Copy-Item \\Server\test\ForensIT\* C:\ProgramData\ForensiT\Migrate
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

# Lancement de la Migration

Start-Process -FilePath "C:\ProgramData\ForensiT\Migrate\Migrate-MyReport.exe"
