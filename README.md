<!--
SPDX-FileCopyrightText: 2022 Mirian Margiani
SPDX-License-Identifier: GFDL-1.3-or-later
-->

![Parking Chaos banner](icon-src/banner.png)

# Parking Chaos for Sailfish OS

<!-- [![Translations](https://hosted.weblate.org/widgets/harbour-parkingchaos/-/translations/svg-badge.svg)](https://hosted.weblate.org/projects/harbour-parkingchaos/translations/) -->
[![Source code license](https://img.shields.io/badge/source_code-GPL--3.0--or--later-yellowdarkgreen)](https://github.com/ichthyosaurus/harbour-parkingchaos/tree/main/LICENSES)
[![REUSE status](https://api.reuse.software/badge/github.com/ichthyosaurus/harbour-parkingchaos)](https://api.reuse.software/info/github.com/ichthyosaurus/harbour-parkingchaos)
[![Development status](https://img.shields.io/badge/development-active-blue)](https://github.com/ichthyosaurus/harbour-parkingchaos)
<!-- [![Liberapay donations](https://img.shields.io/liberapay/receives/ichthyosaurus)](https://liberapay.com/ichthyosaurus) -->

**Rush hour in your parking lot!**

*Parking Chaos* is a clone of the famous “Rush Hour” or “Traffic Jam” game,
written from scratch based on [*ParkMeeCrazy*](https://sourceforge.net/p/parkmeecrazyforsailfishos/code/).

Move the red tractor to the exit on the right by dragging vehicles out of the
way. Horizontal cars can only move left and right, vertical ones can only move
up and down.


## Help and support

You are welcome to leave a comment on
[OpenRepos](https://openrepos.net/content/ichthyosaurus/parking-chaos) or
in the Jolla store.

## Translations

It would be wonderful if the app could be translated in as many languages as possible!

If you just found a minor problem, you can
[open an issue](https://github.com/ichthyosaurus/harbour-parkingchaos/issues/new).
<!-- or [leave a comment in the forum](https://forum.sailfishos.org/t/parking-chaos-support-and-feedback-thread/4566)-->

Please include the following details:

1. the language you were using
2. where you found the error
3. the incorrect text
4. the correct translation

### Manually updating translations

You can follow these steps to manually add or update a translation:

1. *If it did not exist before*, create a new catalog for your language by copying the
   base file [translations/harbour-parkingchaos.ts](translations/harbour-parkingchaos.ts).
   Then add the new translation to [harbour-parkingchaos.pro](harbour-parkingchaos.pro).
2. Add yourself to the list of contributors in [qml/pages/AboutPage.qml](qml/pages/AboutPage.qml).

See [the Qt documentation](https://doc.qt.io/qt-5/qml-qtqml-date.html#details) for
details on how to translate date formats to your *local* format.

## Building and contributing

*Bug reports, and contributions for translations, bug fixes, or new features are always welcome!*

1. Clone the repository: `https://github.com/ichthyosaurus/harbour-parkingchaos.git`
2. Open `harbour-parkingchaos.pro` in Sailfish OS IDE (Qt Creator for Sailfish)
3. To run on emulator, select the `i486` target and press the run button
4. To build for the device, select the `armv7hl` target and deploy all,
   the RPM packages will be in the RPMS folder

Please do not forget to add yourself to the list of contributors in
[qml/pages/AboutPage.qml](qml/pages/AboutPage.qml)!

## License

> Copyright (C) 2020-2022  Mirian Margiani

*Parking Chaos* is Free Software released under the terms of the
[GNU General Public License v3 (or later)](https://spdx.org/licenses/GPL-3.0-or-later.html).
The source code is available [on Github](https://github.com/ichthyosaurus/harbour-parkingchaos).
All documentation is released under the terms of the
[GNU Free Documentation License v1.3 (or later)](https://spdx.org/licenses/GFDL-1.3-or-later.html).

This project follows the [REUSE specification](https://api.reuse.software/info/github.com/ichthyosaurus/harbour-parkingchaos).
