###############################
#TOSHIBA Universal Printer 2  #
################################
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$drivername = "Redacted"
$portName = "Redacted"
$portName2 = "Redacted"
$PortAddress = "Redacted"
$PortAddress2 = "Redacted"

###################
#Staging Drivers   #
###################
C:\Windows\SysNative\pnputil.exe /add-driver "$psscriptroot\Drivers\CNP60MA64.inf" /install

#######################
#Installing Drivers   #
#######################

Add-PrinterDriver -Name $drivername

##########################################################
#Install Printerport | check if the port already exist   #
##########################################################
$checkPortExists = Get-Printerport -Name $portname -ErrorAction SilentlyContinue

if (-not $checkPortExists) 
	{
		Add-PrinterPort -name $portName -PrinterHostAddress $PortAddress
		Add-PrinterPort -name $portName2 -PrinterHostAddress $PortAddress2
	}

####################################
#Check if PrinterDriver Exists     #
####################################
$printDriverExists = Get-PrinterDriver -name $DriverName -ErrorAction SilentlyContinue


##################
#Install Printer #
##################
if ($printDriverExists)
	{
		Add-Printer -Name "Redacted" -PortName $portName -DriverName $DriverName
		Add-Printer -Name "Redacted" -PortName $portName2 -DriverName $DriverName
	}
	else
		{
			Write-Warning "Printer Driver not installed"
		}

SLEEP 360
