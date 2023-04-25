import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtCore

Rectangle {
    id: root

    property url source: ""
    property url browseDialogCurrentFolder: ""
    property alias nearest: nearestButton.checked
    property alias pop: popButton.checked

    signal loadImage(url path)

    Component.onCompleted: {
        root.loadImage(imageUrlBox.url)
    }

    height: 50
    color: "#E7ECF0"

    Settings {
        property alias lastFileLocation: root.browseDialogCurrentFolder
        property alias lastSource: root.source
        property alias lastImageUrl: imageUrlBox.url
        property alias lastNearest: nearestButton.checked
    }

    FileDialog {
        id: browseDialog
        acceptLabel: "Open"
        currentFolder: root.browseDialogCurrentFolder
        onAccepted: imageUrlBox.load(selectedFile)
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
            id: nearestButton
            implicitHeight: 25
            checkable: true
            checked: true
            text: "Nearest"
            icon.source: "qrc:/qt/qml/PixelPeek/icons8-pixel.png"
            icon.width: 24
            icon.height: 24
        }

        Item {
            Layout.minimumWidth: 100
        }

        ImageUrlBox {
            id: imageUrlBox
            Layout.fillWidth: true
            enabled: true
            onOpenClicked: browseDialog.open()
            onLoadImage: function (path) {
                root.loadImage(path)
            }
        }

        Item {
            Layout.minimumWidth: 100
        }

        Button {
            id: popButton
            implicitHeight: 25
            checkable: true
            checked: false
            text: "Pop"
            icon.source: "qrc:/qt/qml/PixelPeek/icons8-picture.svg"
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
