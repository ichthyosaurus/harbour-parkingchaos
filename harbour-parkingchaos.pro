# This file is part of harbour-parkingchaos.
# SPDX-FileCopyrightText: 2020-2024 Mirian Margiani
# SPDX-License-Identifier: GPL-3.0-or-later

# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-parkingchaos
CONFIG += sailfishapp

SOURCES += src/harbour-parkingchaos.cpp

DISTFILES += qml/harbour-parkingchaos.qml \
    qml/cover/*.qml \
    qml/pages/*.qml \
    qml/components/*.qml \
    qml/components/*.js \
    qml/images/*.png \
    rpm/harbour-parkingchaos.changes.in \
    rpm/harbour-parkingchaos.changes.run.in \
    rpm/harbour-parkingchaos.spec \
    rpm/harbour-parkingchaos.yaml \
    translations/*.ts \
    harbour-parkingchaos.desktop

data.files = data
data.path = /usr/share/$${TARGET}

INSTALLS += data

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-parkingchaos-*.ts

QML_IMPORT_PATH += qml/modules

# Note: version number is configured in yaml
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += APP_RELEASE=\\\"$$RELEASE\\\"
include(libs/opal-cached-defines.pri)
