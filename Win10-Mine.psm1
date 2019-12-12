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
	Remove-Item –path %USERPROFILE%\TEMP –recurse
	Remove-Item –path %USERPROFILE%\TMP –recurse
	Remove-ItemProperty -Path "HKCU:\Environment" -Name "TEMP" -ErrorAction SilentlyContinue
	Remove-ItemProperty -Path "HKCU:\Environment" -Name "TMP" -ErrorAction SilentlyContinue
}

Function DisableUACDim {
	Write-Output "Lowering UAC level..."
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0
}

# Export functions
Export-ModuleMember -Function *
