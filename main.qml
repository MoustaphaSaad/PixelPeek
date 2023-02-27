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
            console.log("image changed", imageUrl)
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
            imageViewer.source = path
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
