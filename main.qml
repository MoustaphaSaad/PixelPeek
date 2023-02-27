import QtQuick

Window {
    width: 800
    height: 450
    visible: true
    title: qsTr("Hello World")

    AppBar {
        id: appBar
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        onLoadImage: function (path) {
            imageViewer.load(path)
        }
    }

    ImageViewer {
        id: imageViewer
        anchors {
            top: appBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        smooth: !appBar.nearest
    }
}
