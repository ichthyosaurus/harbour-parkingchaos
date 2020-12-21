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

import QtQuick 2.0
import Sailfish.Silica 1.0
import "board.js" as Board

Item {
    id: root
    width: Math.min(parent.width, parent.height) - 2*Theme.horizontalPageMargin
    height: width
    anchors.horizontalCenter: parent.horizontalCenter

    property bool isPreview: false
    property bool highlighted: false
    property bool debug: false
    readonly property bool containsMouse: guardian.containsMouse || _tileContainsMouse
    property bool _tileContainsMouse: false

    property ListModel map: ListModel {}

    readonly property int goalX: 6
    readonly property int goalY: 2
    readonly property int cellsPerRow: 6
    readonly property double cellWidth: width/cellsPerRow
    readonly property color playerColor: "red"

    Rectangle {
        anchors { fill: parent; margins: -7 }
        color: Theme.highlightDimmerColor
        border.color: Theme.highlightColor
        border.width: 7
        opacity: Theme.opacityHigh
    }

    HighlightImage {
        id: mapgrid
        source: "../images/mapgrid.png"
        color: Theme.highlightColor
        opacity: Theme.opacityHigh
        sourceSize.width: width
        sourceSize.height: height
        anchors.fill: parent
        visible: !isPreview
    }

    MouseArea {
        id: guardian
        anchors.fill: parent
        preventStealing: true
        enabled: !isPreview
    }

    Item {
        id: tileContainer
        anchors.fill: parent

        Repeater {
            model: map
            delegate: Item {
                id: tile
                x: posX*cellWidth
                y: posY*cellWidth
                width: orientation === oHORIZONTAL ? size*cellWidth : 1*cellWidth
                height: orientation === oHORIZONTAL ? 1*cellWidth : size*cellWidth
                enabled: !isPreview

                property double _xBeforeDrag: x
                property double _yBeforeDrag: y

                Rectangle {
                    id: borderRect
                    anchors { fill: parent; margins: 7 }
                    border.width: 7
                    border.color: Qt.lighter(color)
                    radius: 20
                    opacity: isPreview ? 1.0 : 0.9//Theme.opacityHigh
                    color: (mouseArea.pressed || root.highlighted) ? Qt.darker(baseColor) : baseColor

                    property color baseColor: Theme.secondaryColor

                    Rectangle {
                        width: Math.min(parent.height, parent.width) / 2
                        height: width
                        color: parent.border.color
                        anchors.centerIn: parent
                        radius: 90
                        visible: isPlayer && isPreview
                    }

                    Component.onCompleted: {
                        if (isPlayer) {
                            baseColor = playerColor;
                        } else if (isPreview) {
                            baseColor = Board.getColor(60, 300);
                        } else {
                            baseColor = Board.getColor(120, 250);
                        }
                    }
                }

                Image {
                    visible: !isPreview
                    anchors { centerIn: borderRect; margins: 15 }
                    width: orientation === oHORIZONTAL ? borderRect.width : borderRect.height
                    height: orientation === oHORIZONTAL ? borderRect.height : borderRect.width
                    source: isPlayer === true ? Board.getPlayerTile() : Board.getTile(size, index)
                    rotation: orientation === oHORIZONTAL ? 0 : 90
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    preventStealing: true
                    readonly property double pX: parent.x
                    readonly property double pY: parent.y

                    drag.target: tile
                    drag.axis: orientation === oHORIZONTAL ? Drag.XAxis : Drag.YAxis

                    drag.minimumX: pX; drag.maximumX: pX
                    drag.minimumY: pY; drag.maximumY: pY

                    onReleased: {
                        _tileContainsMouse = false

                        // update current position in the model
                        var cellX = Math.round(pX/cellWidth);
                        var cellY = Math.round(pY/cellWidth);
                        posX = cellX; posY = cellY;

                        // visually snap to grid
                        parent.x = cellX*cellWidth;
                        parent.y = cellY*cellWidth;

                        if (pX !== _xBeforeDrag || pY !== _yBeforeDrag) {
                            current.moves += 1;
                        }

                        if (isPlayer &&
                                cellX+(orientation === oHORIZONTAL ? size : 0) === goalX &&
                                cellY+(orientation === oHORIZONTAL ? 0 : size) === goalY) {
                            levelWon();
                        }
                    }

                    onPressed: {
                        _tileContainsMouse = true

                        // re-calculate position boundaries
                        console.log("re-calculating:", index);
                        _xBeforeDrag = pX; _yBeforeDrag = pY;

                        drag.minimumX = 0; drag.maximumX = tileContainer.width-width;
                        drag.minimumY = 0; drag.maximumY = tileContainer.height-height;

                        if (orientation === oHORIZONTAL) {
                            var walkX = (Math.floor(pX/cellWidth))*cellWidth - cellWidth/2
                            while (walkX > 0) {
                                if (tileContainer.childAt(walkX, pY + cellWidth/2) !== null) {
                                    console.log("child at", walkX, pY+cellWidth/2);
                                    drag.minimumX = (Math.floor(walkX/cellWidth)+1)*cellWidth;
                                    walkRect.x = walkX;
                                    walkRect.y = pY+cellWidth/2;
                                    break;
                                } else {
                                    console.log("no child at", walkX, pY+cellWidth/2, "- checking at x =", walkX-cellWidth);
                                    walkX -= cellWidth;
                                    walkRect.x = walkX
                                    walkRect.y = pY+cellWidth/2
                                    continue;
                                }
                            }

                            walkX = (Math.floor(pX/cellWidth))*cellWidth + width + cellWidth/2
                            while (walkX < tileContainer.width) {
                                if (tileContainer.childAt(walkX, pY + cellWidth/2) !== null) {
                                    console.log("b child at", walkX, pY+cellWidth/2);
                                    drag.maximumX = (Math.floor(walkX/cellWidth)-size)*cellWidth;
                                    bWalkRect.x = walkX;
                                    bWalkRect.y = pY+cellWidth/2;
                                    break;
                                } else {
                                    console.log("b no child at", walkX, pY+cellWidth/2, "- checking at x =", walkX-cellWidth);
                                    walkX += cellWidth;
                                    bWalkRect.x = walkX
                                    bWalkRect.y = pY+cellWidth/2
                                    continue;
                                }
                            }
                        } else {
                            var walkY = (Math.floor(pY/cellWidth))*cellWidth - cellWidth/2
                            while (walkY > 0) {
                                if (tileContainer.childAt(pX + cellWidth/2, walkY) !== null) {
                                    console.log("child at", pX+cellWidth/2, walkY);
                                    drag.minimumY = (Math.floor(walkY/cellWidth)+1)*cellWidth;
                                    walkRect.y = walkY;
                                    walkRect.x = pX+cellWidth/2;
                                    break;
                                } else {
                                    console.log("no child at", pX+cellWidth/2, walkY, "- checking at y =", walkY-cellWidth);
                                    walkY -= cellWidth;
                                    walkRect.y = walkY
                                    walkRect.x = pX+cellWidth/2
                                    continue;
                                }
                            }

                            walkY = (Math.floor(pY/cellWidth))*cellWidth + height + cellWidth/2
                            while (walkY < tileContainer.height) {
                                if (tileContainer.childAt(pX + cellWidth/2, walkY) !== null) {
                                    console.log("b child at", pX+cellWidth/2, walkY);
                                    drag.maximumY = (Math.floor(walkY/cellWidth)-size)*cellWidth;
                                    bWalkRect.y = walkY;
                                    bWalkRect.x = pX+cellWidth/2;
                                    break;
                                } else {
                                    console.log("b no child at", pX+cellWidth/2, walkY, "- checking at y =", walkY-cellWidth);
                                    walkY += cellWidth;
                                    bWalkRect.y = walkY
                                    bWalkRect.x = pX+cellWidth/2
                                    continue;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: walkRect
        visible: debug
        color: "yellow"
        width: 20; height: 20
        x: 0; y: 0
    }

    Rectangle {
        id: bWalkRect
        visible: debug
        color: "red"
        width: 20; height: 20
        x: 10; y: 10
    }
}
