#!/usr/bin/env bash

mkdir -p ~/.hammerspoon/Spoons
cp -R ./Spoons ~/.hammerspoon/
cp ./*.lua ~/.hammerspoon/
echo "Installed hammerspoon config. Restart hammerspoon for changes to apply"
