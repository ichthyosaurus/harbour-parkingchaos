#!/bin/bash
#
# This file is part of Opal and has been released into the public domain.
# SPDX-License-Identifier: CC0-1.0
# SPDX-FileCopyrightText: 2020-2022 Mirian Margiani
#
# See https://github.com/Pretty-SFOS/opal/blob/main/snippets/opal-render-icons.md
# for documentation.
#
# @@@ keep this line: based on template v0.3.0
#
c__FOR_RENDER_LIB__="0.3.0"

# Run this script from the same directory where your icon sources are located,
# e.g. <app>/icon-src.
source ../libs/opal-render-icons.sh
cFORCE=false

for i in raw/*.svg; do
    if [[ "$i" -nt "${i#raw/}" ]]; then
        scour "$i" > "${i#raw/}"
    fi
done

cNAME="app icons"
cITEMS=(harbour-parkingchaos)
cRESOLUTIONS=(86 108 128 172)
cTARGETS=(../icons/RESXxRESY)
render_batch

cNAME="graphics"
cITEMS=(
    tile-player@200x100
    tile-02-01@200x100
    tile-02-02@200x100
    tile-02-03@200x100
    tile-02-04@200x100
    tile-02-05@200x100
    tile-02-06@200x100
    tile-02-07@200x100

    tile-03-01@300x100
    tile-03-02@300x100
    tile-03-03@300x100
    tile-03-04@300x100
    tile-03-05@300x100

    mapgrid@600
    cover-background@460x736
    harbour-parkingchaos@256
)
cRESOLUTIONS=(F1)
cTARGETS=(../qml/images)
render_batch
