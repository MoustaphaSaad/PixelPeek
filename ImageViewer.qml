import QtQuick

Rectangle {
    id: workArea

    property alias smooth: image.smooth
    property alias source: image.source

    function clamp(value, min, max) {
        return Math.min(Math.max(value, min), max)
    }

    function restore() {
        image.customScale = 1
        imageArea.x = (workArea.width - imageArea.width) / 2
        imageArea.y = (workArea.height - imageArea.height) / 2
    }

    function loadImage(path) {
        imageViewer.source = path
        restore()
    }

    clip: true
    focus: true
    Keys.onSpacePressed: function (event) {
        workArea.restore()
    }

    Rectangle {
        id: imageArea
        width: image.implicitWidth * image.customScale + border.width * 2
        height: image.implicitHeight * image.customScale + border.width * 2
        x: (workArea.width - width) / 2
        y: (workArea.height - height) / 2
        border.color: "#464B52"
        border.width: 1

        Image {
            fillMode: Image.Tile
            source: "qrc:/PixelPeek/transparent-tile.png"
            anchors {
                fill: parent
                margins: parent.border.width
            }

            Image {
                id: image
                property real minScale: 50 / Math.min(image.implicitWidth, image.implicitHeight)
                property real maxScale: 10
                property real customScale: 1

                anchors.fill: parent
                mipmap: true
                cache: false
            }
        }
    }

    DragHandler {
        target: imageArea
        snapMode: DragHandler.NoSnap
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        propagateComposedEvents: true
        onDoubleClicked: workArea.restore()
        onWheel: function (wheel) {
            if (wheel.modifiers & Qt.ControlModifier) {
                let newScale = image.customScale
                newScale *= wheel.angleDelta.y > 0 ? 1 + 0.05 : 1 - 0.05
                newScale = clamp(newScale, image.minScale, image.maxScale)
                if (newScale != image.customScale) {
                    let mousePos = Qt.point(wheel.x, wheel.y)
                    let imageAreaPos = mapToItem(imageArea, mousePos)
                    let scaleOrigin = Qt.point(imageArea.width / 2, imageArea.height / 2)
                    if (imageArea.contains(imageAreaPos))
                        scaleOrigin = imageAreaPos

                    let widthScaleFactor = clamp(scaleOrigin.x / imageArea.width, 0, 1)
                    let heightScaleFactor = clamp(scaleOrigin.y / imageArea.height, 0, 1)

                    let newWidth = image.implicitWidth * newScale + border.width * 2
                    let newHeight = image.implicitHeight * newScale + border.width * 2
                    let newX = imageArea.x + imageArea.width * widthScaleFactor - newWidth * widthScaleFactor
                    let newY = imageArea.y + imageArea.height * heightScaleFactor - newHeight * heightScaleFactor

                    imageArea.x = newX
                    imageArea.y = newY
                    image.customScale = newScale
                }
                wheel.accepted = true
            } else {
                wheel.accepted = false
            }
        }
    }

    PinchArea {
        anchors.fill: parent
        onPinchUpdated: function (pinch) {
            let newScale = clamp(pinch.scale, image.minScale, image.maxScale)
            if (newScale !== image.customScale) {
                let mousePos = pinch.center
                let imageAreaPos = mapToItem(imageArea, mousePos)
                let scaleOrigin = Qt.point(imageArea.width / 2, imageArea.height / 2)
                if (imageArea.contains(imageAreaPos))
                    scaleOrigin = imageAreaPos

                let widthScaleFactor = clamp(scaleOrigin.x / imageArea.width, 0, 1)
                let heightScaleFactor = clamp(scaleOrigin.y / imageArea.height, 0, 1)

                let newWidth = image.implicitWidth * newScale + border.width * 2
                let newHeight = image.implicitHeight * newScale + border.width * 2
                let newX = imageArea.x + imageArea.width * widthScaleFactor - newWidth * widthScaleFactor
                let newY = imageArea.y + imageArea.height * heightScaleFactor - newHeight * heightScaleFactor

                imageArea.x = newX
                imageArea.y = newY
                image.customScale = newScale
            }
        }
    }
}
