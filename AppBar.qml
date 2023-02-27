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
        anchors.fill: parent
        Label {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter
            text: root.source
        }

        Button {
            text: "Browse"
            onClicked: browseDialog.open()
        }
    }

    ImageUrlBox {
        anchors {
            centerIn: parent
        }
        enabled: true

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
