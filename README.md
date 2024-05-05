# Build Aseprite.app from source for Apple Silicon

- https://gist.github.com/tizee/7a4f03a61592b91239d2caa1a763f413
- My build environment:
    - macOS version: 13.5
    - Aseprite version: 1.3.6 at git commit hash: `92edd5f`
- Requirements:
    - `ninja`: `brew install ninja`
    - `cmake`: `brew install cmake`
- Aseprite's forked of `skia`: Download compiled Aseprite's fork of skia from https://github.com/aseprite/skia/releases
    - skia-m102 for Aseprite-1.3.6 at `92edd5f`: https://github.com/aseprite/skia/releases/tag/m102-861e4743af
    - extract it to `$HOME/deps/skia`

```bash
cd aseprite
mkdir build
cd build
cmake \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_OSX_ARCHITECTURES=arm64 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=13.5 \
  -DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk \
  -DLAF_BACKEND=skia \
  -DSKIA_DIR=$HOME/deps/skia \
  -DSKIA_LIBRARY_DIR=$HOME/deps/skia/out/Release-arm64 \
  -DSKIA_LIBRARY=$HOME/deps/skia/out/Release-arm64/libskia.a \
  -DPNG_ARM_NEON:STRING=on \
  -G Ninja \
  ..
  ninja aseprite
```

- build output in `build/bin`

## Install Aseprite.app

- Modified from trial version of Aseprite.app package

```bash
export $TARGET=/path/to/aseprite/build/bin
mv $TARGET/aseprite Aseprite.app/Contents/MacOS
mv $TARGET/data Aseprite.app/Contents/Resources
mv Aseprite.app /Applications
```
### Avoid damaged App

- Check `com.apple.quarantine`
```
xattr /Applications/Aseprite.app
```
- Remove `com.apple.quarantine`
```
xattr -r -d /Applications/Aseprite.app
```

### Add to Path environment variable

- `aseprite` binary executable is also a command-line tool so it's possible to add it to PATH.

```bash
export PATH="$PATH:/Applications/Aseprite.app/Contents/MacOS/"
```

## Reference

- x86 cpu macOS: https://github.com/haxpor/aseprite-macos-buildsh
    - It's sort of outdated now.
- https://www.newverse.wiki/knows/aseprite/
- `INSTALL.md` in Aseprite repo: https://github.com/aseprite/aseprite/blob/main/INSTALL.md#macos-details

## How about LibreSprite

- https://github.com/LibreSprite/LibreSprite
    - I think it's less maintained than Aseprite


