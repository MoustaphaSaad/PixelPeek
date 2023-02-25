import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ImageViewer {
        anchors {
            fill: parent
            margins: 20
        }
    }
}
