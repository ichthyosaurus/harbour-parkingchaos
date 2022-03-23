/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: 2020-2022  Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
.pragma library

var TILES_COUNT_BY_SIZE = [0, 0, 7, 5]

function getColor(iDarkLuma, iLightLuma) {
    // adapted from https://stackoverflow.com/a/14810261
    // For pastel, pass in higher luma dark/light integers - ie getRandomColor(120, 250).
    if (iDarkLuma === undefined) iDarkLuma = 50;
    if (iLightLuma === undefined) iLightLuma = 250;

    for (var i=0; i<20; i++) {
        var sColour = ('ffffff' + Math.floor(Math.random() * 0xFFFFFF).toString(16)).substr(-6);

        var rgb = parseInt(sColour, 16); // convert rrggbb to decimal
        var r = (rgb >> 16) & 0xff;  // extract red
        var g = (rgb >>  8) & 0xff;  // extract green
        var b = (rgb >>  0) & 0xff;  // extract blue

        var iLuma = 0.2126 * r + 0.7152 * g + 0.0722 * b; // per ITU-R BT.709

        if (iLuma > iDarkLuma && iLuma < iLightLuma) return '#'+sColour;
    }

    return '#'+sColour;
}

function getTile(size, tileIndex) {
    if (size !== 2 && size !== 3) {
        console.error("invalid tile size:", size);
        return "";
    }

    return "../images/tile-0%1-0%2.png".arg(size).arg((tileIndex%TILES_COUNT_BY_SIZE[size])+1);
}

function getPlayerTile() {
    return "../images/tile-player.png"
}
