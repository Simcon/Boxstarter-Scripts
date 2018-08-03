# Description: Boxstarter Script  
# Author: Paul Cook
# Host setup

Disable-UAC

#--- Windows Features ---
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

#--- File Explorer Settings ---
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Enabling developer mode on the system ---
# Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

#--- Windows Subsystems/Features ---
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
#choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#--- Ubuntu ---
#Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile ~/Ubuntu.appx -UseBasicParsing
#Add-AppxPackage -Path ~/Ubuntu.appx

#--- Define Packages to Install ---
$Packages = 'firefox',`
            'GoogleChrome',`
            'winrar'

#--- Install Packages ---
ForEach ($PackageName in $Packages)
{choco install $PackageName -y}

#--- Remove unwanted Store Apps ---

#Get-AppxPackage | Where-Object {$_.name -Match "3dbuilder|windowsalarms|windowscommunicationapps|windowscamera|officehub|skypeapp|getstarted|zunemusic|windowsmaps|solitairecollection|bingfinance|zunevideo|bingnews|onenote|people|windowsphone|photos|bingsports|soundrecorder|bingweather|xboxapp"} | Remove-AppxPackage -ea 0

#--- Define Store Apps to install ---
$Apps = '9wzdncrfj140',` # Twitter
        '9NCBCSZSJRSB',` # Spotify
        'CFQ7TTC0K5D7',` # Word
        'CFQ7TTC0K5F3',` # Excel
        '9NBLGGH4Z1SP',` # ShareX
        '9NKSQGP7F2NH',` # WhatsApp
        '9NBLGGH444L4',` # UBlock Origin Edge Extension
        '9NBLGGH4V7X0'   # LastPass Edge Extension

#--- Install Store Apps ---
ForEach ($AppId in $Apps)
{Start-Process "ms-windows-store://pdp/?ProductId=$AppId"}

#--- Tools ---
#code --install-extension msjsdiag.debugger-for-chrome
#code --install-extension msjsdiag.debugger-for-edge

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula