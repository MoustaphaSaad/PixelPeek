import QtQuick

Rectangle {
    id: workArea

    function clamp(value, min, max) {
        return Math.min(Math.max(value, min), max)
    }

    clip: true
    color: "#EEEEEE"

    Rectangle {
        id: imageArea
        width: image.implicitWidth * image.customScale + border.width * 2
        height: image.implicitHeight * image.customScale + border.width * 2
        x: (workArea.width - width) / 2
        y: (workArea.height - height) / 2
        border.color: "#222222"
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
                property real minScale: 0.1
                property real maxScale: 5
                property real customScale: 1
                property real customScaleAcc: 1

                Timer {
                    id: scaleAccTimer
                    interval: 100
                    repeat: false
                    onTriggered: image.customScaleAcc = 1
                }

                anchors.fill: parent
                source: "file:///W:/Projects/rtow/go-image.ppm"
            }
        }

        DragHandler {}
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        onWheel: function (wheel) {
            if (wheel.modifiers & Qt.ControlModifier) {
                console.log("wheel", wheel.angleDelta.y)
                let newScale = image.customScale
                newScale *= wheel.angleDelta.y > 0 ? 1 + 0.02 * image.customScaleAcc : 1 - 0.02 * image.customScaleAcc
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
                    image.customScaleAcc += 0.5
                    scaleAccTimer.restart()
                }
                wheel.accepted = true
            } else {
                wheel.accepted = false
            }
        }
        propagateComposedEvents: true
    }

    //    Flickable {
    //        anchors.fill: parent
    //        contentWidth: Math.max(image.implicitWidth * pinchArea.scale, width)
    //        contentHeight: Math.max(image.implicitHeight * pinchArea.scale, height)
    //        pixelAligned: true
    //        clip: true

    //        PinchArea {
    //            id: pinchArea
    //            anchors {
    //                fill: parent
    //            }
    //            pinch.target: image
    //            pinch.maximumScale: 5
    //            pinch.minimumScale: 0.1
    //            pinch.dragAxis: Pinch.XAndYAxis

    //            Image {
    //                id: image
    //                anchors.centerIn: parent
    //                fillMode: Image.PreserveAspectFit
    //                transformOrigin: Item.Center

    //            }
    //        }
    //    }
}
