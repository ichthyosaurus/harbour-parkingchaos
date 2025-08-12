/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.0
import "modules/Opal/About"

ChangelogList {
    ChangelogItem {
        version: "1.3.0-1"
        date: "2025-08-12"
        paragraphs: [
            "- Added translations: Portuguese (Brazil)<br>" +
            "- Updated translations: Estonian, French, Portuguese (Brazil), Slovak, Spanish, Swedish, Turkish, Ukrainian<br>" +
            "- Fixed an issue that prevented translations from actually getting shipped<br>" +
            "- Updated Opal modules and merged many translations from Opal"
        ]
    }
    ChangelogItem {
        version: "1.2.0-1"
        date: "2024-10-14"
        paragraphs: [
            "- Updated translations: Chinese, English, Estonian, German, Norwegian Bokmål, Polish, Russian, Swedish, Ukrainian<br>" +
            "- Added a new support page for donations and contributions<br>" +
            "- Added an in-app changelog<br>" +
            "- Added support for all screen orientations<br>" +
            "- Fixed overflowing text on the cover<br>" +
            "- Updated translator credits (directly from Weblate)<br>" +
            "- General maintenance and infrastructure updates to bring the app back into shape"
        ]
    }
    ChangelogItem {
        version: '1.1.0'
        date: "2022-03-24"
        paragraphs: [
            '- Translations: added Polish, added Russian, added Hungarian, updated German<br>' +
            '- Added a new Sailjail profile (no permissions required)<br>' +
            '- Fixed settings being saved at an invalid location<br>' +
            '- Updated about page (now using Opal.About)<br>' +
            '- Updated all graphics, reducing overall package size<br>' +
        '' ]
    }
    ChangelogItem {
        version: '1.0.1'
        date: "2020-12-21"
        paragraphs: [
            '- Improved compatibility with smaller screens (smaller than Xperia X)<br>' +
            '- Improved detection of when to disable pulley menus<br>' +
            '- Updated all translations<br>' +
        '' ]
    }
    ChangelogItem {
        version: '1.0.0'
        date: "2020-07-17"
        paragraphs: [
            '- First public release<br>' +
        '' ]
    }
}
