import QtQuick
import QtQuick.Controls
import PixelPeek

Window {
    id: root
    property var loadDatetime

    function reloadImage() {
        imageViewer.source = ""
        imageViewer.source = `image://history/${historySlider.value}`
        console.log("image changed", Driver.watcher.imageUrl)
        root.loadDatetime = new Date()
    }

    width: 800
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
            historySlider.value = historyImageCount
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

        Slider {
            id: historySlider
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 10
            }
            from: 1
            to: Driver.historyImageCount
            onValueChanged: root.reloadImage()
        }
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
        loadDatetime: root.loadDatetime
    }
}
