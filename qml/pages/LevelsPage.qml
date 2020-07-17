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
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All

    SilicaGridView {
        id: grid
        model: levelsModel
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Levels")
        }

        readonly property double _baseWidth: 1.5*Theme.itemSizeExtraLarge
        cellWidth: width > _baseWidth ? width/(width/_baseWidth) : width
        cellHeight: cellWidth+8*Theme.paddingMedium

        delegate: BackgroundItem {
            id: delegate
            width: grid.cellWidth
            height: grid.cellHeight

            highlighted: down || current.index === index

            onClicked: {
                console.log("level selected:", index);
                levelRequested(index);
                pageStack.pop();
            }

            Board {
                id: board
                anchors { top: parent.top; topMargin: 2*Theme.paddingMedium }
                isPreview: true
                highlighted: delegate.down
                map: tiles
            }

            InfoLabel {
                anchors {
                    left: parent.left; right: parent.right
                    top: board.bottom; bottom: parent.bottom
                    margins: Theme.paddingMedium
                }
                highlighted: delegate.highlighted
                level: index+1
                currentMoves: -1
                minMoves: minimumMoves
            }
        }

        VerticalScrollDecorator {}
    }

    Component.onCompleted: {
        grid.positionViewAtIndex(current.index, GridView.Center);
    }
}
