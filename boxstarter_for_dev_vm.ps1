# Description: Boxstarter Script  
# Author: Paul Cook
# Dev settings for my app development

Disable-UAC

#--- Windows Features ---
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

#--- File Explorer Settings ---
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Enabling developer mode on the system ---
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

#--- Windows Subsystems/Features ---
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#--- Ubuntu ---
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx

#--- Define Packages to Install ---
$Packages = 'docker-for-windows',`
            'firefox',`
            'github-desktop',`
            'GoogleChrome',`
            'visualstudiocode',`
            'visualstudio2017community',`
            'visualstudio2017-workload-netweb',`
            'visualstudio2017-workload-netcoretools',`
            'winrar'

#--- Install Packages ---
ForEach ($PackageName in $Packages)
{choco install $PackageName -y}

#--- Remove unwanted Store Apps ---

Get-AppxPackage | Where-Object {$_.name -Match "3dbuilder|windowsalarms|windowscommunicationapps|windowscamera|officehub|skypeapp|getstarted|zunemusic|windowsmaps|solitairecollection|bingfinance|zunevideo|bingnews|onenote|people|windowsphone|photos|bingsports|soundrecorder|bingweather|xboxapp"} | Remove-AppxPackage -ea 0

# #--- Define Store Apps to install ---
# $Apps = '9NBLGGH4Z1SP' # ShareX

# #--- Install Store Apps ---
# ForEach ($AppId in $Apps)
# {Start-Process "ms-windows-store://pdp/?ProductId=$AppId"}

#--- Tools ---
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula