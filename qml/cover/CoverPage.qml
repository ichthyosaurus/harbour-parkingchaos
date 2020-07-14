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
import "../pages"

CoverBackground {
    Board {
        id: board
        anchors { top: parent.top; topMargin: 2*Theme.paddingMedium }
        isPreview: true
        map: current.map
    }

    Label {
        anchors {
            top: board.bottom; bottom: parent.bottom
            left: parent.left; right: parent.right
            margins: Theme.paddingMedium
        }

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        truncationMode: TruncationMode.Fade
        color: Theme.highlightColor
        text: qsTr("Level %1").arg(current.level) + "\n" + qsTr("Moves: %1 / %2").arg(current.moves).arg(current.minimumMoves)
    }
}
