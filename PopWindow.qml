import QtQuick
import QtQuick.Controls

Window {
    id: window

    property alias source: image.source
    property alias smooth: image.smooth
    property int resizeTolerance: 12

    signal restore

    width: Math.min(image.implicitWidth, 320)
    height: image.implicitHeight * width / image.implicitWidth
    minimumWidth: 100
    minimumHeight: 100
    flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint

    Image {
        anchors.fill: parent
        fillMode: Image.Tile
        source: "qrc:/PixelPeek/transparent-tile.png"
    }

    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        mipmap: true
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

    Button {
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: window.resizeTolerance
        }

        icon.source: "qrc:/PixelPeek/icons8-restore.png"
        onClicked: window.restore()
    }

    Rectangle {
        anchors {
            left: parent.left
            bottom: parent.bottom
            margins: window.resizeTolerance
        }

        color: "black"
        opacity: 0.40
        width: 40
        height: 20
    }
}
