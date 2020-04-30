#!/bin/sh

swift build --configuration release
cp -f .build/release/Til /usr/local/bin/Til
