import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    TextField {
        Layout.fillWidth: true
        implicitWidth: 300
        implicitHeight: 25
        placeholderText: "Load an Image"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Button {
        implicitHeight: 25
        text: "Open"
        icon.source: "qrc:/PixelPeek/icons8-folder.svg"
    }
}
