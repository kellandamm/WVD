#Set Variables for VHDLocations
$vhdprofile = "\\fslogix\profiles"
$vhdoffice = "\\fslogix\office"
$temppath = "temp"

#Creating a Temp Folder for install
Write-Host "Creating Temporary folder for Install"
    New-Item -Path "C:\$temppath\" -ItemType Directory -Force | Out-Null
        
#Installing Fslogix
Write-Host "Downloading and Installing FSLogix"
    Invoke-WebRequest -Uri 'https://aka.ms/fslogix_download' -OutFile "C:\$temppath\fslogix.zip"
          Start-Sleep -Seconds 20
                Expand-Archive -Path "C:\$temppath\fslogix.zip" -DestinationPath "C:\$temppath\fslogix\"  -Force
                    Invoke-Expression -Command "C:\$temppath\fslogix\x64\Release\FSLogixAppsSetup.exe /install /quiet /norestart"
#Configuring Registry      
Write-host "Configuring Registry Entries for FSLogix"
    New-Item hklm:\software\FSLogix\Profiles -Force
    New-ItemProperty -Path hklm:\software\FSLogix\Profiles -Name Enabled -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path hklm:\software\FSLogix\Profiles -Name VHDLocations -Value "$vhdprofile" -PropertyType String  -Force
    New-Item hklm:\software\policies\FSLogix\ODFC -Force
    New-ItemProperty -Path hklm:\software\policies\FSLogix\ODFC -Name Enabled -Value 1 -PropertyType DWORD -Force
    New-ItemProperty -Path hklm:\software\policies\FSLogix\ODFC -Name VHDLocations -Value "$vhdoffice" -PropertyType String -Force
