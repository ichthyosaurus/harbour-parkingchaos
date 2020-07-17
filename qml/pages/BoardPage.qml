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
import "../sf-about-page/about.js" as About
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.PortraitMask

    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: column.height
        interactive: true

        onInteractiveChanged: console.log("menus enabled:", interactive)

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: About.pushAboutPage(pageStack)
            }
            MenuItem {
                text: qsTr("Level selection")
                onClicked: pageStack.push(Qt.resolvedUrl("LevelsPage.qml"))
            }
        }

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Parking Chaos")
            }

            Board {
                id: board
                isPreview: false
                map: current.map
                onContainsMouseChanged: if (containsMouse) flick.interactive = false
                InverseMouseArea {
                    anchors.fill: parent
                    onPressedOutside: flick.interactive = true
                }
            }

            Item {
                width: parent.width
                height: 2*Theme.paddingLarge
            }

            InfoLabel {
                id: infoLabel
                highlighted: true
                anchors {
                    left: parent.left; right: parent.right
                    margins: Theme.horizontalPageMargin
                }
            }

            Item {
                width: parent.width
                height: 2*Theme.paddingLarge
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 3*Theme.paddingMedium

                IconButton {
                    icon.source: "image://theme/icon-m-left"
                    onClicked: levelRequested(current.index-1)
                    enabled: current.index > 0
                }
                IconButton {
                    icon.width: Theme.iconSizeLarge; icon.height: icon.width
                    icon.source: "image://theme/icon-m-reload"
                    onClicked: levelRequested(current.index)
//                    enabled: current.moves > 0
                }
                IconButton {
                    icon.source: "image://theme/icon-m-right"
                    onClicked: levelRequested(current.index+1)
                    enabled: current.index < levelsModel.count-1
                }
            }
        }
    }
}
