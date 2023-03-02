import QtQuick
import PixelPeek

Window {
    id: root
    property var loadDatetime

    width: 800
    height: 450
    visible: !appBar.pop
    title: qsTr("PixelPeek - v" + Driver.version)

    ImageWatcher {
        id: imageWatcher
        imageUrl: imageViewer.source
        onImageChanged: function (imageUrl) {
            imageViewer.source = ""
            imageViewer.source = imageUrl
            console.log("image changed", imageUrl)
            root.loadDatetime = new Date()
        }
    }

    AppBar {
        id: appBar
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        onLoadImage: function (path) {
            imageViewer.loadImage(path)
            root.loadDatetime = new Date()
        }
        onPopChanged: {
            if (pop)
                popWindow.show()
            else
                popWindow.hide()
        }
    }

    ImageViewer {
        id: imageViewer
        anchors {
            top: appBar.bottom
            left: parent.left
            right: parent.right
            bottom: statusBar.top
        }
        smooth: !appBar.nearest
    }

    StatusBar {
        id: statusBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        loadDatetime: root.loadDatetime
    }

    PopWindow {
        id: popWindow
        visible: false
        source: imageViewer.source
        smooth: !appBar.nearest
        onRestore: {
            appBar.pop = false
            hide()
        }
        loadDatetime: root.loadDatetime
    }
}
