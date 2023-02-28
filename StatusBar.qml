import QtQuick
import QtQuick.Layouts

Rectangle {
    height: 25
    color: "#E7ECF0"

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
            right: parent.right
            margins: 8
        }

        Text {
            text: "Koko"
            color: "#464B52"
        }
    }
}
