import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    spacing: 0

    TextField {
        Layout.fillWidth: true
        implicitWidth: 300
        implicitHeight: 25
        placeholderText: "Load an Image"

        background: Rectangle {
            color: "#B4BAC4"
//            border.color: "#464B52"
            radius: 4
        }
    }

    ImageUrlBoxButton {
        implicitHeight: 25
        text: "Load"
    }

    //
}
