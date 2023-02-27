import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    AppBar {
        id: header
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
    }

    ImageViewer {
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
