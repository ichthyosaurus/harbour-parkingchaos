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
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
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
                onContainsMouseChanged: flick.interactive = !containsMouse
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
