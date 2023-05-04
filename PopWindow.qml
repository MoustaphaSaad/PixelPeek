import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "Utils.js" as Utils

Window {
    id: window

    property alias source: image.source
    property alias smooth: image.smooth
    property int resizeTolerance: 12
    property int selectedImageIndex: 0
    property var loadDatetime: new Date()
    onLoadDatetimeChanged: updateLoadedLabel()

    signal restore

    function updateLoadedLabel() {
        lastUpdated.text = Utils.timeDifference(new Date(), loadDatetime)
    }

    function requestFocus() {
        imageBackground.focus = true
    }

    width: 320
    height: 240
    minimumWidth: 100
    minimumHeight: 100
    flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint

    onVisibilityChanged: function (visibility) {
        if (visibility !== Window.FullScreen) {
            window.width = Math.min(image.implicitWidth, 320)
            window.height = image.implicitHeight * window.width / image.implicitWidth
        }
    }

    Image {
        id: imageBackground
        anchors.fill: parent
        fillMode: Image.Tile
        source: "qrc:/qt/qml/PixelPeek/transparent-tile.png"
        focus: true
        Keys.onPressed: function(event) {
            if (event.key == Qt.Key_Left || event.key == Qt.Key_Up)
            {
                if (Driver.historyImageList.selectedImageIndex > 0)
                    Driver.historyImageList.selectedImageIndex--
            }
            else if (event.key == Qt.Key_Right || event.key == Qt.Key_Down)
            {
                if (Driver.historyImageList.selectedImageIndex + 1 < Driver.historyImageCount)
                    Driver.historyImageList.selectedImageIndex++
            }
        }
    }

    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        mipmap: true
        cache: false
    }

    DragHandler {
        id: resizeHandler
        grabPermissions: TapHandler.CanTakeOverFromAnything
        target: null

        onActiveChanged: {
            if (active) {
                const p = resizeHandler.centroid.position
                let e = 0
                if (p.x / width < 0.10) {
                    e |= Qt.LeftEdge
                }
                if (p.x / width > 0.90) {
                    e |= Qt.RightEdge
                }
                if (p.y / height < 0.10) {
                    e |= Qt.TopEdge
                }
                if (p.y / height > 0.90) {
                    e |= Qt.BottomEdge
                }

                if (e !== 0)
                    window.startSystemResize(e)
                else
                    window.startSystemMove()
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        onDoubleClicked: {
            if (window.visibility === Window.FullScreen)
                window.showNormal()
            else
                window.showFullScreen()
        }

        onPositionChanged: function (p) {
            if (p.buttons & Qt.LeftButton || resizeHandler.active)
                return

            let margins = window.resizeTolerance

            let isLeft = p.x < margins
            let isRight = p.x > width - margins
            let isTop = p.y < margins
            let isBottom = p.y > height - margins

            if (isLeft && isTop)
                cursorShape = Qt.SizeFDiagCursor
            else if (isLeft && isBottom)
                cursorShape = Qt.SizeBDiagCursor
            else if (isRight && isTop)
                cursorShape = Qt.SizeBDiagCursor
            else if (isRight && isBottom)
                cursorShape = Qt.SizeFDiagCursor
            else if (isLeft || isRight)
                cursorShape = Qt.SizeHorCursor
            else if (isTop || isBottom)
                cursorShape = Qt.SizeVerCursor
            else
                cursorShape = Qt.ArrowCursor
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: updateLoadedLabel()
    }

    Button {
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: window.resizeTolerance
        }

        icon.source: "qrc:/qt/qml/PixelPeek/icons8-restore.png"
        onClicked: window.restore()
    }

    Rectangle {
        anchors {
            left: parent.left
            bottom: parent.bottom
            margins: window.resizeTolerance
        }

        color: "#AA000000"
        width: labelArea.implicitWidth + 16
        height: labelArea.implicitHeight + 8

        RowLayout {
            id: labelArea
            anchors {
                centerIn: parent
            }

            Text {
                text: `Image#${selectedImageIndex}`
                font.pointSize: 8
                color: "white"
            }

            Text {
                id: lastUpdated
                font.pointSize: 8
                color: "white"
            }
        }
    }
}
