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
import Nemo.Configuration 1.0
import "sf-about-page/about.js" as About
import "pages"

ApplicationWindow
{
    initialPage: Component { BoardPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
    bottomMargin: successBanner.visibleSize
    readonly property int oHORIZONTAL: 1
    readonly property int oVERTICAL: 0

    signal levelRequested(var index)
    signal levelWon()
    property ListModel levelsModel: ListModel {}
    property QtObject current: QtObject {
        property ListModel map: ListModel {}
        property int index: 0
        property int level: 0
        property int moves: 0
        property int minimumMoves: 0
    }

    onLevelWon: successBanner.show();
    onLevelRequested: {
        successBanner.hide();

        var level = levelsModel.get(index);
        if (!level) {
            console.log("error: failed to activate level '%1'".arg(index));
            return;
        } else {
            lastLevelIndex.value = index;
            lastLevelMap.value = "";
            lastLevelMoves.value = 0;
        }

        // copy the map so we can modify it, but reset it
        // by copying the original data again
        current.map.clear();
        for (var i = 0; i < level.tiles.count; i++) {
            current.map.append(level.tiles.get(i));
        }

        current.index = index;
        current.level = index+1;
        current.moves = 0;
        current.minimumMoves = level.minimumMoves;
    }

    DockedPanel {
        id: successBanner
        modal: true
        open: false
        height: bannerColumn.height + 2*Theme.paddingLarge
        width: parent.width
        dock: Dock.Bottom

        Column {
            id: bannerColumn
            width: parent.width

            Item { width: parent.width; height: Theme.paddingLarge }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 2*Theme.horizontalPageMargin
                text: qsTr("Win!");
                font.pixelSize: Theme.fontSizeExtraLarge
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 2*Theme.horizontalPageMargin
                wrapMode: Text.Wrap
                text: qsTr("You completed this level in %1 move(s)!".arg(current.moves), "", current.moves);
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignHCenter
            }

            Item { width: parent.width; height: Theme.paddingLarge }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.paddingMedium
                Button {
                    text: qsTr("Restart")
                    onClicked: levelRequested(current.index)
                }
                Button {
                    text: qsTr("Next level")
                    onClicked: levelRequested(current.index+1)
                }
            }
        }
    }

    ConfigurationValue {
        id: lastLevelIndex
        key: "/lastLevelIndex"
        defaultValue: 0
    }

    ConfigurationValue {
        // TODO implement saving the current status
        id: lastLevelMap
        key: "/lastLevelMap"
        defaultValue: ""
    }

    ConfigurationValue {
        // TODO cf. lastLevelMap
        id: lastLevelMoves
        key: "/lastLevelMoves"
        defaultValue: 0
    }

    Component.onCompleted: {
        About.VERSION_NUMBER = versionNumber;

        var levelsDatabase = dataDirectory + "/levels.json";
        console.log("loading levels from:", levelsDatabase);

        var xhr = new XMLHttpRequest;
        xhr.open("GET", levelsDatabase);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var response = JSON.parse(xhr.responseText);
                console.log("success: levels database loaded (%1 levels)".arg(response.length));
                levelsModel.clear();

                for (var i in response) {
                    levelsModel.append(response[i]);
                }

                levelRequested(lastLevelIndex.value);

                if (lastLevelMap.value !== "") {
                    var map = JSON.parse(lastLevelMap.value);
                    current.map.clear();
                    for (var j in map) {
                        current.map.append(map[j]);
                    }

                    current.moves = lastLevelMoves.value;
                }
            }
        };
        xhr.send();
    }
}
