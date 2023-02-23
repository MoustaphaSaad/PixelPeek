import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    minimumWidth: 640
    minimumHeight: 480

    ImageViewer {
        anchors {
            fill: parent
            margins: 20
        }
    }
}
