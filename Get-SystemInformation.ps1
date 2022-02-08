<#
  Ali's PowerShell Project

#>

#Write-Host writes to the console itself.
Write-Host "***************************************"

#set variable to use in the function to get the date
$date = Get-Date -Format "dd/MM/yyyy"
Write-Host "Today is: ", $date

#Computer name function
Write-Host "The Host Name is: ", $Env:Computername

#Function to get the current user
Write-Host "You are: ", $env:UserName
Write-Host "****************************************"

#Outputs Title
Write-Host "**** Systeminfo *******"

#Converting datetime from wmiobject to the boot time.
Write-Host "System Boot Time: " 
(Get-WmiObject win32_operatingsystem | select @{EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime);}} | ft -HideTableHeaders)

#grabbing the bootdevice name and hiding the table
Write-Host "Boot Device: " 
(Get-CimInstance Win32_OperatingSystem | select BootDevice | ft -HideTableHeaders)

#Function to get the memory from the user piping it through the key word.
$tpmemory = (systeminfo | Select-String 'Total Physical Memory:').ToString().Split(':')[1].Trim()

#Output the memory value
Write-Host "Total Physical Memory: ", $tpmemory

Write-Host "System Manufacturer: " 
Get-CimInstance Win32_ComputerSystem | select Manufacturer | ft -HideTableHeaders

#outputs the Title
Write-Host "**** Operating System Info *******"

#Function to get the name of the OS, then Use write-host to print out the result.
$OSName = ( Get-WmiObject Win32_OperatingSystem ).name
Write-Host "OS name: ", $OSName 

$version =(Get-WmiObject Win32_OperatingSystem).OSArchitecture
Write-Host "OS Version: ", $version

$bios_ver = (Get-WmiObject win32_bios).Version
Write-Host "BIOS Version: ", $bios_ver

#seeks out the string Product ID and pipes it out into the script and specifically 
#grabs the ID number but using string (words) to search
$key = (systeminfo | Select-String 'Product ID')
Write-Host "Product ID: ", $key

#Getting the original install date using object reference for the values.
Write-Host "Original Install Date: ", $objects.Property10


#Title
Write-Host "**** Network Information *******"

#Write-Host "IPv4 Address. . . . . . . . . . . : " 
Write-Host "IPv4 Address. . . . . . . . . . . : "

#using the permaeters find the ip address with the numbers and parse to get the answer
$localIpAddress=((ipconfig | findstr [0-9].\.)[0]).Split()[-1]
$localIpAddress

#function to find the location of the subnet mask 
Write-Host "Subnet Mask . . . . . . . . . . .: "
Get-WmiObject Win32_NetworkAdapterConfiguration | Where IPEnabled | Select IpSubnet | ft -hidetableheaders


Write-Host "DHCP Enabled . . . . . . . . . . .: "


Write-Host "LinkSpeed(MB) . . . . . . . . . : "
#Get-NetAdapter | select linkSpeed | ft -hidetableheaders
$speed = Get-NetAdapter | SELECT speed | ft -HideTableHeaders
$speed

#Title
Write-Host "**** BIOS information: *******"

#Get the bios version from the system 
$bios_ver = (Get-WmiObject win32_bios).Version
Write-Host "BIOS Version: ", $bios_ver

#Get the OS type
Write-Host "System Type: " (Get-WmiObject Win32_OperatingSystem).OSArchitecture