#!/bin/bash

set -euo pipefail

echo ""
echo "Installing Fira Code..."
echo ""

read -r -p "Do you want to install Fira Code? [y/N] " response
if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Fira Code installation skipped"
    exit 0
fi

if [ -x "$(command -v fc-cache)" ]; then
    echo "fc-cache found"
else
    echo "fc-cache not found"
    if [ -x "$(command -v apt)" ]; then
        echo "sudo apt install fontconfig"
        sudo apt install fontconfig -y
    fi
fi

fonts_dir="${HOME}/.local/share/fonts"
if [ ! -d "${fonts_dir}" ]; then
    echo "mkdir -p $fonts_dir"
    mkdir -p "${fonts_dir}"
else
    echo "Found fonts dir $fonts_dir"
fi

version=5.2
zip=Fira_Code_v${version}.zip
curl --fail --location --show-error https://github.com/tonsky/FiraCode/releases/download/${version}/${zip} --output ${zip}
unzip -o -q -d ${fonts_dir} ${zip}
rm ${zip}

fc-cache -f

echo ""
echo "Fira Code installed!"
echo ""
