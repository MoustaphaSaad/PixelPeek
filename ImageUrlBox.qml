import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    id: root
    property alias url: imageUrl.text
    signal openClicked
    signal loadImage(url path)

    function load(path) {
        root.url = path
        root.loadImage(path)
    }

    TextField {
        id: imageUrl
        Layout.fillWidth: true
        implicitWidth: 300
        implicitHeight: 25
        placeholderText: "Load an Image"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        onEditingFinished: root.load(text)
    }

    Button {
        implicitHeight: 25
        text: "Open"
        icon.source: "qrc:/PixelPeek/icons8-folder.svg"
        onClicked: root.openClicked()
    }
}
