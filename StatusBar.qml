import QtQuick
import QtQuick.Layouts
import "Utils.js" as Utils

Rectangle {
    property alias messageVisible: loadedMessage.visible
    property int selectedImageIndex: 0
    property var loadDatetime: new Date()
    property color selectedColor: null
    property bool showSelectedColor: false

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
        id: loadedMessage
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            margins: 8
        }

        Text {
            text: `Image #${selectedImageIndex}:`
            color: "#464B52"
        }

        Text {
            id: lastUpdated
            text: "X seconds ago"
            color: "#464B52"
        }
    }

    RowLayout {
        id: pixelColor
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            margins: 8
        }
        visible: showSelectedColor

        Text {
            id: pixelColortext
            Layout.alignment: Qt.AlignVCenter
            text: `(${selectedColor.r.toFixed(3)}, ${selectedColor.g.toFixed(3)}, ${selectedColor.b.toFixed(3)})`
        }

        Rectangle {
            id: pixelColorSwatch
            Layout.alignment: Qt.AlignVCenter
            color: selectedColor
            width: 10
            height: 10
            border.width: 1
            border.color: "black"
        }
    }
}
