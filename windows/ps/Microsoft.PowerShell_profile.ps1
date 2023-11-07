# Manage Aliases
Remove-Item alias:curl -ErrorAction SilentlyContinue
New-Alias -Name vim -Value nvim -ErrorAction SilentlyContinue

# Access to theme colors
$env:WT_SETTINGS = "$home\dotfiles\windows\wt\settings.json"
$themeName = "Dracula"
$theme = $settings.schemes | Where-Object {$_.name -eq $themeName}

# set prompt
function prompt {
    if ($? -eq 0) {
        $err = " `e[31mPS`e[0m> "
    }
    else {
        $err = " PS> "
    }
    $fullpath = (Convert-Path -LiteralPath $(Get-Location))
    $path = -join @("[", "`e[34m", $fullpath.replace("$HOME", "~"), "`e[0m", "]")
    $username = -join @("`e[32m", $(whoami | Split-Path -Leaf), "`e[0m")
    $hostname = -join @("`e[32m", $(hostname), "`e[0m")
    $prompt = -join @($username, "@", $hostname, ":", $path, $err)
    return $prompt
}


