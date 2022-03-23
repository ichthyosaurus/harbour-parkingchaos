/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: 2022 Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

/*
 * Translators:
 * Please add yourself to the list of contributors below. If your language is already
 * in the list, add your name to the 'entries' field. If you added a new translation,
 * create a new section at the top of the list.
 *
 * Other contributors:
 * Please add yourself to the relevant list of contributors.
 *
 * <...>
 *  ContributionGroup {
 *      title: qsTr("Your language")
 *      entries: ["Existing contributor", "YOUR NAME HERE"]
 *  },
 * <...>
 *
 */

import QtQuick 2.0
//import Sailfish.Silica 1.0
import "../modules/Opal/About"

AboutPageBase {
    id: page
    appName: qsTr("Parking Chaos")
    appIcon: Qt.resolvedUrl("../images/harbour-parkingchaos.png")
    appVersion: APP_VERSION
    appRelease: APP_RELEASE
    description: qsTr("Rush hour in your parking lot!<br><br>" +
                      '<small><em>Parking Chaos</em> is a clone of the famous “Rush Hour” or “Traffic Jam” game, ' +
                      'written from scratch based on <em>ParkMeeCrazy</em>.<br>' +
                      'Move the red tractor to the exit on the right by dragging others out of the way. ' +
                      'Horizontal cars can only move left and right, vertical ones can only move ' +
                      'up and down.</small>')
    mainAttributions: ["2020-2022 Mirian Margiani"]
    sourcesUrl: "https://github.com/ichthyosaurus/harbour-parkingchaos"
    homepageUrl: "https://openrepos.net/content/ichthyosaurus/parking-chaos"

    licenses: License { spdxId: "GPL-3.0-or-later" }
    attributions: [
        Attribution {
            name: "ParkMeeCrazy"
            entries: ["2013 Karsten Todtermuschke, 2011 Mures Andone"]
            licenses: License { spdxId: "GPL-3.0-or-later" }
            sources: "https://sourceforge.net/p/parkmeecrazyforsailfishos/code/ci/master/tree/"
            description: qsTr("Graphics and levels are based on data from ParkMeeCrazy.")
        },
        Attribution {
            name: "PyTraffic"
            entries: ["2001-2005 Michel Van den Bergh"]
            licenses: License { spdxId: "GPL-2.0-or-later" }
            sources: "https://github.com/voyageur/pytraffic"
        },
        OpalAboutAttribution { }
    ]

    extraSections: [
        InfoSection {
            title: qsTr("Acknowledgments")
            smallPrint: qsTr("<small><em>Parking Chaos</em> uses levels and graphics based on " +
                             "data from <em>ParkMeeCrazy</em>, which is released under the terms of the GNU GPL v3+." +
                             "</small><br>Thank you!")
            buttons: [
                InfoButton {
                    text: qsTr("Website")
                    onClicked: page.openOrCopyUrl("https://sourceforge.net/projects/parkmeecrazyforsailfishos")
                }
            ]
        }
    ]

    contributionSections: [
        ContributionSection {
            title: qsTr("Development")
            groups: [
                ContributionGroup {
                    title: qsTr("Programming")
                    entries: ["Mirian Margiani"]
                },
                ContributionGroup {
                    title: qsTr("Graphics Design")
                    entries: ["Mirian Margiani", "Karsten Todtermuschke", "Michel Van den Bergh"]
                }
            ]
        },
        ContributionSection {
            title: qsTr("Translations")
            groups: [
                ContributionGroup { title: qsTr("Swedish"); entries: ["Åke Engelbrektson"]},
                ContributionGroup { title: qsTr("Polish"); entries: ["Atlochowski"]},
                ContributionGroup { title: qsTr("Russian"); entries: ["kvakanet"]},
                ContributionGroup { title: qsTr("Hungarian"); entries: ["1Zgp"]},
                ContributionGroup { title: qsTr("English, German"); entries: ["Mirian Margiani"]}
            ]
        }
    ]
}
