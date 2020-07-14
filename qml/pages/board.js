/*
 * This file is part of harbour-parkingchaos.
 * Copyright (C) 2020  Mirian Margiani
 *
 * harbour-parkingchaos is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * harbour-parkingchaos is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with harbour-parkingchaos.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

.pragma library

var TILES_COUNT_BY_SIZE = [0, 0, 7, 5]

function randomColor(iDarkLuma, iLightLuma) {
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

function randomTile(size) {
    if (size !== 2 && size !== 3) {
        console.error("invalid tile size:", size)
        return ""
    }

    return "../images/tile-0%1-0%2.png".arg(size).arg(Math.floor(Math.random()*TILES_COUNT_BY_SIZE[size])+1)
}

function playerTile() {
    return "../images/tile-player.png"
}
