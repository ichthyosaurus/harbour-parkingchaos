.pragma library
// This script is a library. This improves performance, but it means that no
// variables from the outside can be accessed.


// -- TRANSLATORS
// Please add yourself to the list of contributors. If your language is already
// in the list, add your name to the 'values' field:
//     example: {label: qsTr("Your language"), values: ["Existing contributor", "YOUR NAME HERE"]},
//
// If you added a new translation, create a new section at the top of the list:
//     example:
//          var TRANSLATIONS = [
//              {label: qsTr("Your language"), values: ["YOUR NAME HERE"]},
//          [...]
//
var TRANSLATIONS = [
    {label: qsTr("English"), values: ["Mirian Margiani"]},
    {label: qsTr("German"), values: ["Mirian Margiani"]}
]


// -- OTHER CONTRIBUTORS
// Please add yourself the the list of contributors.
var DEVELOPMENT = [
    {label: qsTr("Programming"), values: ["Mirian Margiani"]},
    {label: qsTr("Graphics Design"), values: ["Mirian Margiani", "Karsten Todtermuschke", "Michel Van den Bergh"]},
    {label: qsTr("ParkMeeCrazy"), values: ["Mures Andone", "Karsten Todtermuschke"]},
]


var VERSION_NUMBER = "1.0" // set in main.qml's Component.onCompleted
var APPINFO = {
    iconPath: "/usr/share/icons/hicolor/172x172/apps/harbour-parkingchaos.png",
    description: qsTr("Rush hour in your parking lot!<br><br>" +
                      '<small><em>Parking Chaos</em> is a clone of the famous “Rush Hour” or “Traffic Jam” game, ' +
                      'written from scratch based on <em>ParkMeeCrazy</em>.<br>' +
                      'Move the red tractor to the exit on the right by dragging others out of the way. ' +
                      'Horizontal cars can only move left and right, vertical ones can only move ' +
                      'up and down.</small>'),
    author: "Mirian Margiani",
    sourcesLink: "https://github.com/ichthyosaurus/harbour-parkingchaos",
    sourcesText: "",

    extraInfoTitle: qsTr("Acknowledgements"),
    extraInfoText: qsTr("<small><em>Parking Chaos</em> is a re-write of <em>ParkMeeCrazy</em> and " +
                        "uses levels and graphics based on theirs. <em>ParkMeeCrazy</em> is released " +
                        "under the terms of the GNU GPL v3+.</small><br><br>Thank you!"),
    extraInfoLinkText: "ParkMeeCrazy",
    extraInfoLink: "https://sourceforge.net/projects/parkmeecrazyforsailfishos",

    enableContributorsPage: true, // whether to enable 'ContributorsPage.qml'
    contribDevelopment: DEVELOPMENT,
    contribTranslations: [] //TRANSLATIONS // enable when there are other contributors
}

function aboutPageUrl() {
    return Qt.resolvedUrl("AboutPage.qml");
}

function pushAboutPage(pageStack) {
    APPINFO.versionNumber = VERSION_NUMBER;
    pageStack.push(aboutPageUrl(), APPINFO);
}
