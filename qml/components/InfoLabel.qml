/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: 2020-2024  Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.6
import Sailfish.Silica 1.0

SilicaItem {
    id: root

    property int level: current.level
    property int currentMoves: current.moves
    property int minMoves: current.minimumMoves
    property double fontSize: Theme.fontSizeMedium
    property double minimumFontSize: Theme.fontSizeExtraSmall

    height: column.height
    width: parent.width

    Column {
        id: column
        height: levelsLabel.implicitHeight + movesLabel.implicitHeight
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: levelsLabel
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            highlighted: root.highlighted
            font.pixelSize: root.fontSize
            fontSizeMode: Text.HorizontalFit
            minimumPixelSize: root.minimumFontSize
            truncationMode: TruncationMode.Fade

            text: qsTr("Level %1").arg(level)

            palette {
                primaryColor: Theme.secondaryColor
                highlightColor: Theme.secondaryHighlightColor
            }
        }

        TextMetrics {
            id: metrics
            text: movesLabel.text
            font.pixelSize: root.minimumFontSize
        }

        Label {
            id: movesLabel
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            highlighted: root.highlighted
            font.pixelSize: metrics.width > width ?
                root.minimumFontSize : root.fontSize
            fontSizeMode: Text.HorizontalFit
            minimumPixelSize: root.minimumFontSize
            wrapMode: Text.Wrap

            text: currentMoves >= 0 ?
                      qsTr("%1 / %2 moves").arg(currentMoves).arg(minMoves) :
                      qsTr("%1 moves").arg(minMoves)

            palette {
                primaryColor: Theme.primaryColor
                highlightColor: Theme.highlightColor
            }
        }
    }
}
