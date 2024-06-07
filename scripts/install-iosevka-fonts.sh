#!/bin/bash
RELEASE=29.2.1
mkdir -p /tmp/iosevka-font/$RELEASE
cd /tmp/iosevka-font/$RELEASE

wget https://github.com/be5invis/Iosevka/releases/download/v$RELEASE/PkgTTC-Iosevka-$RELEASE.zip
wget https://github.com/be5invis/Iosevka/releases/download/v$RELEASE/PkgTTC-IosevkaAile-$RELEASE.zip
wget https://github.com/be5invis/Iosevka/releases/download/v$RELEASE/PkgTTC-IosevkaCurly-$RELEASE.zip
wget https://github.com/be5invis/Iosevka/releases/download/v$RELEASE/PkgTTC-IosevkaCurlySlab-$RELEASE.zip
wget https://github.com/be5invis/Iosevka/releases/download/v$RELEASE/PkgTTC-IosevkaEtoile-$RELEASE.zip
wget https://github.com/be5invis/Iosevka/releases/download/v$RELEASE/PkgTTC-IosevkaSlab-$RELEASE.zip

unzip \*.zip

mkdir -p ~/.fonts/iosevka
mv *.ttc ~/.fonts/iosevka/.

sudo fc-cache -fv
