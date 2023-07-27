#!/bin/sh

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

# Install xcode
xcode-select --install > /dev/null

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# uninstall homebrew
#  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
# m2 macだとpathを通す必要があるため設定
echo '# Set PATH for Homebrew (m2 mac)' >> ~/.zprofile
cat << EOF >> ~/.zprofile
if [ "$(uname)" != "Linux" ] ; then
   eval "\$(/opt/homebrew/bin/brew shellenv)"
fi
EOF
eval "$(/opt/homebrew/bin/brew shellenv)"
