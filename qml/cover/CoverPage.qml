/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: 2020-2022  Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

CoverBackground {
    Board {
        id: board
        anchors { top: parent.top; topMargin: 2*Theme.paddingMedium }
        isPreview: true
        map: current.map
    }

    InfoLabel {
        highlighted: false
        anchors {
            top: board.bottom; bottom: parent.bottom
            left: parent.left; right: parent.right
            margins: Theme.paddingMedium
        }
    }
}
