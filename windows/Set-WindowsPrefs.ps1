# Install scoop
Invoke-RestMethod get.scoop.sh | Invoke-Expression

# Install scoop packages
scoop install ` 
curl `
file `
git `
jq `
neovim `
python `
shasum `
upx `
gawk

# Set Dark Mode
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0

# Taskbar preferences
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -Value 0 # Align Left 
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarDa -Value 0 # Hide Widgets
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarMn -Value 0 # Hide Chat
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -Value 0 # Hide TaskView
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name SearchBoxTaskbarMode -Value 0 # Hide SearchBox

# Turn off start menu search
New-Item -Path HKCU:\Software\Policies\Microsoft\Windows -Name Explorer
New-ItemProperty -Path HKCU:\Software\Policies\Microsoft\Windows\Explorer -Name DisableSearchBoxSuggestions -PropertyType DWord -Value 1
# Classic start menu
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Start_ShowClassicMode -PropertyType DWord -Value 1
# Import-StartLayout $env:USERPROFILE\dotfiles\windows\startmenu.json # Exported with Export-StartLayout <output-path>

# Link settings files
# Windows Terminal
New-Item -Force -ItemType SymbolicLink -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Target $env:USERPROFILE\dotfiles\windows\wt\settings.json 

# PowerShell
New-Item -Force -ItemType SymbolicLink -Path $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Target $env:USERPROFILE\dotfiles\windows\ps\Microsoft.PowerShell_profile.ps1
