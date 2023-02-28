import QtQuick
import QtQuick.Layouts

Rectangle {
    property var loadDatetime: new Date()

    function setLoadDatetime(time) {
        loadDatetime = time
        updateLoadedLabel()
    }

    function timeDifference(current, previous) {
        var msPerMinute = 60 * 1000
        var msPerHour = msPerMinute * 60
        var msPerDay = msPerHour * 24
        var msPerMonth = msPerDay * 30
        var msPerYear = msPerDay * 365

        var elapsed = current - previous

        if (elapsed < msPerMinute) {
            return Math.round(elapsed / 1000) + ' seconds ago'
        } else if (elapsed < msPerHour) {
            return Math.round(elapsed / msPerMinute) + ' minutes ago'
        } else if (elapsed < msPerDay) {
            return Math.round(elapsed / msPerHour) + ' hours ago'
        } else if (elapsed < msPerMonth) {
            return 'approximately ' + Math.round(
                        elapsed / msPerDay) + ' days ago'
        } else if (elapsed < msPerYear) {
            return 'approximately ' + Math.round(
                        elapsed / msPerMonth) + ' months ago'
        } else {
            return 'approximately ' + Math.round(
                        elapsed / msPerYear) + ' years ago'
        }
    }

    function updateLoadedLabel() {
        lastUpdated.text = timeDifference(new Date(), loadDatetime)
    }

    height: 25
    color: "#E7ECF0"

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: updateLoadedLabel()
    }

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: 1
        color: "#464B52"
    }

    RowLayout {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            margins: 8
        }

        Text {
            text: "Updated:"
            color: "#464B52"
        }

        Text {
            id: lastUpdated
            text: "XOdsfdsgfsdg"
            color: "#464B52"
        }
    }
}
