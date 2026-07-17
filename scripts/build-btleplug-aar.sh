#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
JAVA_MODULE="$REPO_ROOT/third_party/btleplug/src/droidplug/java"
AAR_DEST="$REPO_ROOT/flutter/android/app/libs"
AAR_NAME="btleplug.aar"

info() { printf '\033[0;32m[build-aar]\033[0m %s\n' "$*"; }
die()  { printf '\033[0;31m[build-aar] ERROR:\033[0m %s\n' "$*" >&2; exit 1; }

if [ ! -f "$JAVA_MODULE/gradlew" ]; then
    info "btleplug submodule not initialized; fetching..."
    git -C "$REPO_ROOT" submodule update --init --recursive third_party/btleplug \
        || die "Failed to init the btleplug submodule."
fi

pick_jdk() {
    for candidate in \
        "${BTLEPLUG_JAVA_HOME:-}" \
        /usr/lib/jvm/java-17-temurin-jdk \
        /usr/lib/jvm/temurin-17-jdk \
        /usr/lib/jvm/java-17-openjdk \
        /usr/lib/jvm/java-21-openjdk; do
        [ -n "$candidate" ] && [ -x "$candidate/bin/javac" ] && { echo "$candidate"; return 0; }
    done
    return 1
}
JAVA_HOME="$(pick_jdk)" || die "No JDK 17/21 found. Install one (e.g. Temurin 17) or set BTLEPLUG_JAVA_HOME."
export JAVA_HOME
export PATH="$JAVA_HOME/bin:$PATH"
info "Using JDK: $JAVA_HOME"

ANDROID_SDK="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Android/Sdk}}"
[ -d "$ANDROID_SDK" ] || die "Android SDK not found at $ANDROID_SDK. Set ANDROID_HOME."
export ANDROID_HOME="$ANDROID_SDK"
printf 'sdk.dir=%s\n' "$ANDROID_SDK" > "$JAVA_MODULE/local.properties"
info "Android SDK: $ANDROID_SDK"

info "Running Gradle assembleRelease in $JAVA_MODULE ..."
( cd "$JAVA_MODULE" && chmod +x ./gradlew && ./gradlew --no-daemon assembleRelease )

SRC_AAR="$JAVA_MODULE/build/outputs/aar/droidplug-release.aar"
[ -f "$SRC_AAR" ] || die "Expected AAR not found at $SRC_AAR"

mkdir -p "$AAR_DEST"
cp -f "$SRC_AAR" "$AAR_DEST/$AAR_NAME"
info "Copied AAR -> $AAR_DEST/$AAR_NAME"
info "Done. Rebuild the Flutter app to pick up the new AAR."
