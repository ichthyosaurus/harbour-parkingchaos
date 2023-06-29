/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: 2022-2023 Mirian Margiani
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
import Sailfish.Silica 1.0 as S
import Opal.About 1.0 as A
import "../modules/Opal/Attributions"

A.AboutPageBase {
    id: root

    appName: qsTr("Parking Chaos")
    appIcon: Qt.resolvedUrl("../images/%1.png".arg(Qt.application.name))
    appVersion: APP_VERSION
    appRelease: APP_RELEASE

    allowDownloadingLicenses: false
    sourcesUrl: "https://github.com/ichthyosaurus/%1".arg(Qt.application.name)
    homepageUrl: "https://forum.sailfishos.org/t/apps-by-ichthyosaurus/15753"
    translationsUrl: "https://hosted.weblate.org/projects/%1".arg(Qt.application.name)
    changelogList: Qt.resolvedUrl("../Changelog.qml")
    licenses: A.License { spdxId: "GPL-3.0-or-later" }

    donations.text: donations.defaultTextCoffee
    donations.services: [
        A.DonationService {
            name: "Liberapay"
            url: "https://liberapay.com/ichthyosaurus"
        }
    ]

    description: qsTr("Rush hour in your parking lot!<br><br> " +
                      '<i>Parking Chaos</i> is a clone of the famous “Rush Hour” or “Traffic Jam” game, ' +
                      'written from scratch based on <i>ParkMeeCrazy</i>.<br><br> ' +
                      'Move the red tractor to the exit on the right by dragging others out of the way. ' +
                      'Horizontal cars can only move left and right, vertical ones can only move ' +
                      'up and down.')
    mainAttributions: ["2020-2023 Mirian Margiani"]

    attributions: [
        A.Attribution {
            name: "ParkMeeCrazy"
            entries: ["2013 Karsten Todtermuschke, 2011 Mures Andone"]
            licenses: License { spdxId: "GPL-3.0-or-later" }
            sources: "https://sourceforge.net/p/parkmeecrazyforsailfishos/code/ci/master/tree/"
            description: qsTr("Graphics and levels are based on data from ParkMeeCrazy.")
        },
        A.Attribution {
            name: "PyTraffic"
            entries: ["2001-2005 Michel Van den Bergh"]
            licenses: License { spdxId: "GPL-2.0-or-later" }
            sources: "https://github.com/voyageur/pytraffic"
        },
        A.OpalAboutAttribution {}
    ]

    extraSections: [
        A.InfoSection {
            title: qsTr("Acknowledgments")
            smallPrint: qsTr("<i>Parking Chaos</i> uses levels and graphics based on " +
                             "data from <i>ParkMeeCrazy</i>, which is released under the terms of the GNU GPL v3+." +
                             "<br>Thank you!")
            buttons: [
                A.InfoButton {
                    text: qsTr("Website")
                    onClicked: root.openOrCopyUrl("https://sourceforge.net/projects/parkmeecrazyforsailfishos")
                }
            ]
        }
    ]

    contributionSections: [
        A.ContributionSection {
            title: qsTr("Development")
            groups: [
                A.ContributionGroup {
                    title: qsTr("Programming")
                    entries: ["Mirian Margiani"]
                },
                A.ContributionGroup {
                    title: qsTr("Graphics Design")
                    entries: ["Mirian Margiani", "Karsten Todtermuschke", "Michel Van den Bergh"]
                }
            ]
        },
        A.ContributionSection {
            title: qsTr("Translations")
            groups: [
                A.ContributionGroup { title: qsTr("Swedish"); entries: ["Åke Engelbrektson"]},
                A.ContributionGroup { title: qsTr("Polish"); entries: ["Atlochowski"]},
                A.ContributionGroup { title: qsTr("Russian"); entries: ["kvakanet"]},
                A.ContributionGroup { title: qsTr("Hungarian"); entries: ["1Zgp"]},
                A.ContributionGroup { title: qsTr("English, German"); entries: ["Mirian Margiani"]}
            ]
        }
    ]
}
