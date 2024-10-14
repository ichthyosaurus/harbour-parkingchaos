/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: 2020-2024  Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: root
    allowedOrientations: Orientation.All

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
            width: root.width
            spacing: Theme.paddingMedium

            property int reservedTop: header.height + spacing
            property int reservedBottom: Theme.paddingMedium

            PageHeader {
                id: header
                title: qsTr("Parking Chaos")
            }

            Item {
                id: contentItem
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 2*Theme.horizontalPageMargin
                height: root.height
                        - column.reservedTop
                        - column.reservedBottom

                states: [
                    State {
                        when: root.orientation & Orientation.PortraitMask
                        AnchorChanges {
                            target: board
                            anchors {
                                top: parent.top
                                left: undefined
                                horizontalCenter: parent.horizontalCenter
                            }
                        }
                    },
                    State {
                        when: root.orientation & Orientation.LandscapeMask
                        AnchorChanges {
                            target: board
                            anchors {
                                top: parent.top
                                left: parent.left
                                horizontalCenter: undefined
                            }
                        }
                        AnchorChanges {
                            target: controlsContainer
                            anchors {
                                top: contentItem.top
                                left: board.right
                                right: contentItem.right
                            }
                        }
                        PropertyChanges {
                            target: controlsContainer
                            height: parent.height
                                    + app.bottomMargin
                        }
                    }
                ]

                Board {
                    id: board
                    width: height
                    height: Math.min(parent.width,
                                     parent.height + app.bottomMargin)

                    isPreview: false
                    map: current.map
                    onContainsMouseChanged: {
                        flick.interactive = !containsMouse
                    }

                    InverseMouseArea {
                        anchors.fill: parent
                        onPressedOutside: flick.interactive = true
                    }
                }

                Item {
                    id: controlsContainer
                    height: root.height
                            - column.reservedTop
                            - board.y
                            - board.height
                            + app.bottomMargin
                    anchors {
                        top: board.bottom
                        left: parent.left
                        right: parent.right
                    }

                    Item {
                        height: childrenRect.height
                        anchors {
                            left: parent.left
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }

                        InfoLabel {
                            id: infoLabel
                            highlighted: true
                            fontSize: Theme.fontSizeLarge
                        }

                        Row {
                            anchors {
                                top: infoLabel.bottom
                                topMargin: Math.max(
                                    controlsContainer.height
                                    - infoLabel.height
                                    - height
                                    - 6*Theme.paddingLarge,
                                    Theme.paddingLarge)
                                horizontalCenter: parent.horizontalCenter
                            }
                            spacing: 3*Theme.paddingMedium

                            IconButton {
                                icon.source: "image://theme/icon-m-left"
                                onClicked: levelRequested(current.index-1)
                                enabled: current.index > 0
                            }
                            IconButton {
                                icon.width: Theme.iconSizeLarge
                                icon.height: icon.width
                                icon.source: "image://theme/icon-m-reload"
                                onClicked: levelRequested(current.index)
                                enabled: current.moves > 0
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
        }
    }
}
