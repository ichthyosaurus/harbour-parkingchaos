/*
 * This file is part of harbour-parkingchaos.
 * SPDX-FileCopyrightText: Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.0
import "modules/Opal/About"

ChangelogList {
    ChangelogItem {
        version: '1.1.0'
        date: "2022-03-24"
        paragraphs: [
            '- translations: added Polish, added Russian, added Hungarian, updated German<br>' +
            '- added a new Sailjail profile (no permissions required)<br>' +
            '- fixed settings being saved at an invalid location<br>' +
            '- updated about page (now using Opal.About)<br>' +
            '- updated all graphics, reducing overall package size<br>' +
        '' ]
    }
    ChangelogItem {
        version: '1.0.1'
        date: "2020-12-21"
        paragraphs: [
            '- improved compatibility with smaller screens (smaller than Xperia X)<br>' +
            '- improved detection of when to disable pulley menus<br>' +
            '- updated all translations<br>' +
        '' ]
    }
    ChangelogItem {
        version: '1.0.0'
        date: "2020-07-17"
        paragraphs: [
            '- first public release<br>' +
        '' ]
    }
}
