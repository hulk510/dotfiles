# Do everything.
all: init link defaults brew

# Set initial preference.
init:
	mac/init.sh

# Link dotfiles.
link:
	./link.sh

# Set macOS system preferences.
defaults:
	mac/defaults.sh

# Install macOS applications.
brew:
	mac/brew.sh
