#!/usr/bin/env bash
# Builds the Tune In APK from ../../<game>.html without Gradle.
# Needs: JDK, Android build-tools 34 (BUILD_TOOLS) and android.jar for API 35 (ANDROID_JAR).
# Usage: BUILD_TOOLS=/path/to/build-tools ANDROID_JAR=/path/to/android.jar ./build.sh tune-in-v1
set -euo pipefail
cd "$(dirname "$0")"
GAME="${1:-tune-in-v1}"
BT="${BUILD_TOOLS:?set BUILD_TOOLS}"
JAR="${ANDROID_JAR:?set ANDROID_JAR}"
OUT=build
rm -rf "$OUT" && mkdir -p "$OUT/assets" "$OUT/classes" "$OUT/res"

cp "../../$GAME.html" "$OUT/assets/index.html"

"$BT/aapt2" compile --dir res -o "$OUT/res/res.zip"
"$BT/aapt2" link -o "$OUT/unsigned.apk" -I "$JAR" --manifest AndroidManifest.xml \
  -A "$OUT/assets" "$OUT/res/res.zip" --auto-add-overlay

javac -nowarn --release 8 -classpath "$JAR" -d "$OUT/classes" $(find src -name '*.java') 2>/dev/null
"$BT/d8" --release --lib "$JAR" --min-api 26 --output "$OUT" $(find "$OUT/classes" -name '*.class')
(cd "$OUT" && zip -q unsigned.apk classes.dex)

"$BT/zipalign" -f -p 4 "$OUT/unsigned.apk" "$OUT/aligned.apk"
[ -f debug.keystore ] || keytool -genkeypair -keystore debug.keystore -storepass android -keypass android \
  -alias tunein -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=Tune In Debug" >/dev/null 2>&1
"$BT/apksigner" sign --ks debug.keystore --ks-pass pass:android --key-pass pass:android --v4-signing-enabled false \
  --out "../../$GAME.apk" "$OUT/aligned.apk"
"$BT/apksigner" verify "../../$GAME.apk"
echo "Built ../../$GAME.apk"
