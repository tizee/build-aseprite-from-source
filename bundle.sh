#!/bin/sh

# TARGET=~/projects/app-projects/aseprite/build
cp $TARGET/bin/aseprite ./Aseprite.app/Contents/MacOS
cp -r $TARGET/bin/data ./Aseprite.app/Contents/Resources
cp -r ./Aseprite.app /Applications/Aseprite.app
