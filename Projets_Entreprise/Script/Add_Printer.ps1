###############################
#Variables #
################################
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$drivername = "Canon Generic Plus PCL6"
$portName = "Printer"
$PortAddress = "10.0.0.0"


###################
#Ajout du pilote #
###################
C:\Windows\SysNative\pnputil.exe /add-driver "$psscriptroot\Drivers\CNP60MA64.inf" /install

#######################
#Installation du pilote #
#######################

Add-PrinterDriver -Name $drivername

##########################################################
#Installation du port d'imprimante | vérifier son existence #
##########################################################
$checkPortExists = Get-Printerport -Name $portname -ErrorAction SilentlyContinue
if (-not $checkPortExists) 
{
Add-PrinterPort -name $portName -PrinterHostAddress $PortAddress
}

####################################
#Vérification du pilote #
####################################
$printDriverExists = Get-PrinterDriver -name $DriverName -ErrorAction SilentlyContinue


##################
#Installation de l'imprimante #
##################
if ($printDriverExists)
{
Add-Printer -Name "Office" -PortName $portName -DriverName $DriverName
}
else
{
Write-Warning "Printer Driver not installed"
}

SLEEP 360