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

# Enable aero peek
# remove extra one drive env vars
# turn on auto hide systray icons
# hide/show certain systra icons
# virtual desktop show window on all desktops
# alt tab all desktops
# set computer name

# Export functions
Export-ModuleMember -Function *
