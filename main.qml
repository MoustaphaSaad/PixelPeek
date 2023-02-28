import QtQuick
import PixelPeek

Window {
    width: 800
    height: 450
    visible: !appBar.pop
    title: qsTr("Hello World")

    ImageWatcher {
        id: imageWatcher
        imageUrl: imageViewer.source
        onImageChanged: function (imageUrl) {
            imageViewer.source = ""
            imageViewer.source = imageUrl
            console.log("image changed", imageUrl)
            statusBar.setLoadDatetime(new Date())
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
            statusBar.setLoadDatetime(new Date())
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
    }

    PopWindow {
        visible: appBar.pop
        source: imageViewer.source
        smooth: !appBar.nearest
        onRestore: {
            close()
            appBar.pop = false
        }
    }
}
