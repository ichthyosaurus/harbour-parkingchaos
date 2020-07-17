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

Label {
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    truncationMode: TruncationMode.Fade

    highlighted: false
    property int level: current.level
    property int currentMoves: current.moves
    property int minMoves: current.minimumMoves

    text: qsTr("Level %1").arg(level) +
          "\n" +
          (currentMoves >= 0 ? qsTr("Moves: %1 / %2").arg(currentMoves).arg(minMoves) :
                              qsTr("Moves: %1").arg(minMoves))
}
