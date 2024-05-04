# Build Aseprite.app from source for Apple Silicon

- https://gist.github.com/tizee/7a4f03a61592b91239d2caa1a763f413
- Requirements:
  - `ninja`: `brew install ninja`
  - `cmake`: `brew install cmake`
- Aseprite's forked of `skia`: Download compiled Aseprite's fork of skia from https://github.com/aseprite/skia/releases
  - extract it to `$HOME/deps/skia`

```
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

```
export $TARGET=/path/to/aseprite/build/bin
mv $TARGET/aseprite Aseprite.app/Contents/MacOS
mv $TARGET/data Aseprite.app/Contents/Resources
mv Aseprite.app /Applications
```
