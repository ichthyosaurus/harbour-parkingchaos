# NOTICE:
#
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

DISTFILES += qml/sf-about-page/*.qml \
    qml/sf-about-page/license.html \
    qml/sf-about-page/about.js

data.files = data
data.path = /usr/share/$${TARGET}

INSTALLS += data

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-parkingchaos-de.ts \
    translations/harbour-parkingchaos-en.ts
