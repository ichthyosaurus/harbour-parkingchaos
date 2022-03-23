/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: 2020-2022  Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
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
