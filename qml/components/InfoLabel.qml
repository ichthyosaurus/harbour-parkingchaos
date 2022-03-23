/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: 2020-2022  Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
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
