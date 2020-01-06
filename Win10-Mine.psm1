##########
#region Privacy Tweaks
##########

Function UpdateEnvironmentVariables {
	Write-Output "Updating environment variables..."
	Set-ItemProperty -Path "HKCU:\Environment" -Name "Desktop" -Type ExpandString -Value "%USERPROFILE%\Desktop"
	Set-ItemProperty -Path "HKCU:\Environment" -Name "M2_REPO" -Type ExpandString -Value "%USERPROFILE%\.m2\repository"
}

Function RemoveUserTempDirs {
	Write-Output "Removing user temp directories..."
	Remove-Item -Path %USERPROFILE%\AppData\Local\TEMP -Recurse
	Remove-Item -Path %USERPROFILE%\AppData\Local\TMP -Recurse
	Set-ItemProperty -Path "HKCU:\Environment" -Name "Desktop" -Type ExpandString -Value "%USERPROFILE%\Desktop"
	Remove-ItemProperty -Path "HKCU:\Environment" -Name "TEMP" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\Environment" -Name "TMP" -ErrorAction SilentlyContinue
}

Function DisableUACDim {
	Write-Output "Lowering UAC level..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0
}

Function InstallMsftBloatTwo {
	Write-Output "Installing hand picked Microsoft applications..."
	Get-AppxPackage -AllUsers "Microsoft.BingWeather" | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
	Get-AppxPackage -AllUsers "Microsoft.MicrosoftSolitaireCollection" | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
	Get-AppxPackage -AllUsers "Microsoft.MSPaint" | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
	Get-AppxPackage -AllUsers "Microsoft.People" | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
	Get-AppxPackage -AllUsers "Microsoft.RemoteDesktop" | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
	Get-AppxPackage -AllUsers "Microsoft.WindowsAlarms" | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
	Get-AppxPackage -AllUsers "Microsoft.WindowsCamera" | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
	Get-AppxPackage -AllUsers "Microsoft.windowscommunicationsapps" | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
	Get-AppxPackage -AllUsers "Microsoft.Windows.Photos" | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
}

Function EnableAdminSharesTwo {
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Type DWord -Value 1
}


Function ConfigurePlacesBar {
	Write-Output "Configuring Places Bar..."

	$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\Placesbar"

	If (!(Test-Path $Path)) {
		New-Item -Path $Path -Force | Out-Null
	}
	Set-ItemProperty -Path $Path -Name "Place0" -Type String  -Value "Desktop"
	Set-ItemProperty -Path $Path -Name "Place1" -Type String -Value "Downloads"
	Set-ItemProperty -Path $Path -Name "Place2" -Type String -Value "MyComputer"
	Set-ItemProperty -Path $Path -Name "Place3" -Type String -Value $Home
	# Set-ItemProperty -Path $Path -Name "Place4" -Type String -Value "C:\Kaplan\source"
}

Function SetComputerName {
	Write-Output "Setting Computer name..."

	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" -Name "ComputerName" -Type String  -Value "KAP-IT-6127"
}

# Enable aero peek
# remove extra one drive env vars
# turn on auto hide systray icons
# hide/show certain systra icons
# virtual desktop show window on all desktops
# alt tab all desktops
# set computer name via param
# Set additional places bar via param

# Export functions
Export-ModuleMember -Function *
