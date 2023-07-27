#!/bin/bash

sudo apt update
sudo apt install build-essential procps curl file git

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


echo '# Set PATH, for Homebrew (linux)' >> ~/.zprofile
cat << EOF >> ~/.zprofile
if [ "\$(uname -s)" = "Linux" ] ; then
  eval "\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
EOF
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
