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
