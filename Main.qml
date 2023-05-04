import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import PixelPeek

Window {
    id: root

    function reloadImage() {
        imageViewer.source = ""
        imageViewer.source = `image://history/${Driver.historyImageList.selectedImageIndex}`
        console.log("image changed", Driver.watcher.imageUrl)
    }

    width: 950
    height: 450
    visible: !appBar.pop
    title: qsTr("PixelPeek - v" + Driver.version)

    Connections {
        target: Driver

        function onReloadImage() {
            root.reloadImage()
        }

        function onHistoryImageCountChanged(historyImageCount) {
            console.log(`history image count ${historyImageCount}`)
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
            Driver.watcher.imageUrl = path
            imageViewer.restore()
        }
        onPopChanged: {
            if (pop)
                popWindow.show()
            else
                popWindow.hide()
        }
    }

    SplitView {
        anchors {
            top: appBar.bottom
            left: parent.left
            right: parent.right
            bottom: statusBar.top
        }

        Component.onCompleted: imageViewerRestoreTimer.start()

        // I have no idea why the splitview addition breaks the initialization of image to be
        // centered in the work area, but this timer "waits" for the anchors and layouts to be
        // "stable" then it triggers a restore to center the image to the work area
        Timer {
            id: imageViewerRestoreTimer
            interval: 100
            repeat: false
            onTriggered: imageViewer.restore()
        }

        ImageViewer {
            id: imageViewer
            SplitView.fillWidth: true
            SplitView.fillHeight: true
            smooth: !appBar.nearest
        }

        HistoryViewer {
            SplitView.fillHeight: true
            SplitView.preferredWidth: 250
            clip: true
        }
    }

    StatusBar {
        id: statusBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        selectedImageIndex: Driver.historyImageList.selectedImageIndex
        loadDatetime: Driver.historyImageList.selectedImage.timestamp
    }

    PopWindow {
        id: popWindow
        visible: false
        source: imageViewer.source
        smooth: !appBar.nearest
        onRestore: {
            imageViewer.restore()
            appBar.pop = false
            hide()
        }
        selectedImageIndex: Driver.historyImageList.selectedImageIndex
        loadDatetime: Driver.historyImageList.selectedImage.timestamp
    }
}
