import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import PixelPeek
import "Utils.js" as Utils

Window {
    id: root

    function reloadImage() {
        imageViewer.source = ""
        imageViewer.source = `image://history/${Driver.historyImageList.selectedImageIndex}`
        console.log("image changed", Driver.watcher.imageUrl)
    }

    function reloadMagnifyImage() {
        magnify.source = ""
        magnify.source = `image://history/magnify`
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

        function onReloadMagnifyImage() {
            root.reloadMagnifyImage()
        }

        function onHistoryImageCountChanged(historyImageCount) {
            console.log(`history image count ${historyImageCount}`)
        }

        function onMagnifiedColorChanged(color) {
            statusBar.selectedColor = color
        }
    }

    MouseArea {
        id: magnifyMouseArea

        function updateMagnifiedImage() {
            let imagePos = mapToItem(imageViewer.imageItem, mouseX, mouseY)
            let rect = Qt.rect(imagePos.x - magnify.sourceSize.width / 2, imagePos.y - magnify.sourceSize.height / 2, magnify.sourceSize.width, magnify.sourceSize.height)
            Driver.magnifySelectedImage(imageViewer.imageScale, rect)
        }

        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onPressed: {
            updateMagnifiedImage()
            magnify.visible = true
        }
        onReleased: magnify.visible = false
        onPositionChanged: if (pressed) updateMagnifiedImage()
    }

    Magnifier
    {
        id: magnify
        imageScale: imageViewer.imageScale
        x: magnifyMouseArea.mouseX - width / 2
        y: magnifyMouseArea.mouseY - height / 2
        z: 1
        visible: false
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
            if (Driver.historyImageCount > 0) {
                if (pop) {
                    popWindow.show()
                    popWindow.requestFocus()
                } else {
                    popWindow.hide()
                }
            } else {
                appBar.pop = false
            }
        }
    }

    SplitView {
        id: splitArea
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
        loadDatetime: Driver.historyImageList.selectedImage ? Driver.historyImageList.selectedImage.timestamp : null
        messageVisible: Driver.historyImageList.selectedImage != null
        showSelectedColor: true
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
            imageViewer.forceActiveFocus()
        }
        selectedImageIndex: Driver.historyImageList.selectedImageIndex
        loadDatetime: Driver.historyImageList.selectedImage ? Driver.historyImageList.selectedImage.timestamp : null
    }
}
