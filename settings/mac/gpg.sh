#!/bin/bash

# brewが必要なのでbrewを入れて起きたい
brew install pinentry-mac
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent
