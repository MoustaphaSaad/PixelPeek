import QtQuick
import QtQuick.Layouts
import "Utils.js" as Utils

Rectangle {
    property var loadDatetime: new Date()
    onLoadDatetimeChanged: updateLoadedLabel()

    function updateLoadedLabel() {
        lastUpdated.text = Utils.timeDifference(new Date(), loadDatetime)
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
