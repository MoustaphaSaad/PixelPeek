import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.settings

Rectangle {
    id: root
    property url source: ""
    property url browseDialogCurrentFolder: ""
    height: 50
    color: "#E7ECF0"

    Settings {
        property alias lastFileLocation: root.browseDialogCurrentFolder
        property alias lastSource: root.source
    }

    FileDialog {
        id: browseDialog
        acceptLabel: "Open"
        currentFolder: root.browseDialogCurrentFolder
        onAccepted: root.source = selectedFile
        nameFilters: ["Images (*.ppm *.jpg *.jpeg *.png *.bmp)", "All files (*.*)"]
    }

    RowLayout {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            margins: 8
        }

        Button {
            implicitHeight: 25
            checkable: true
            checked: true
            text: "Nearest"
            icon.source: "qrc:/PixelPeek/icons8-pixel.png"
            icon.width: 24
            icon.height: 24
        }

        Item {
            Layout.minimumWidth: 100
        }

        ImageUrlBox {
            Layout.fillWidth: true
            enabled: true
        }

        Item {
            Layout.minimumWidth: 100
        }

        Button {
            implicitHeight: 25
            checkable: true
            checked: true
            text: "Pop"
            icon.source: "qrc:/PixelPeek/icons8-picture.svg"
        }
    }

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 1
        color: "#464B52"
    }
}
