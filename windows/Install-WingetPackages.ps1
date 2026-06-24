# Install winget packages
# ids sourced from https://winstall.app/
$packages = @(
    "Microsoft.PowerShell"
    "cURL.cURL"
    "Git.Git"
    "jqlang.jq"
    "Neovim.Neovim"
    "Python.Python.3"
    "GnuWin32.Gawk"
    "astral-sh.uv"
)

foreach ($package in $packages) {
    winget install -e --id $package
}