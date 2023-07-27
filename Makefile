# Do everything.
all: init defaults brew

# Set initial preference.
init:
	settings/mac/init.sh

# Set macOS system preferences.
defaults:
	settings/mac/defaults.sh

# Install macOS applications.
brew:
	settings/mac/brew.sh
