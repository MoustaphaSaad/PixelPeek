import QtQuick

Item {

    Image {
        anchors.fill: parent
        fillMode: Image.Tile
        source: "qrc:/PixelPeek/transparent-tile.png"
    }

    Flickable {
        anchors.fill: parent
        contentWidth: image.implicitWidth * pinchArea.scale
        contentHeight: image.implicitHeight * pinchArea.scale
        pixelAligned: true
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        PinchArea {
            id: pinchArea
            anchors {
                fill: parent
            }
            pinch.target: image
            pinch.maximumScale: 5
            pinch.minimumScale: 0.1
            pinch.dragAxis: Pinch.XAndYAxis

            Image {
                id: image
                source: "file:///W:/Projects/rtow/go-image.ppm"
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        onWheel: function (wheel) {
            if (wheel.modifiers & Qt.ControlModifier) {
                let newScale = pinchArea.scale
                newScale *= wheel.angleDelta.y > 0 ? 1.05 : 0.95
                newScale = Math.max(newScale, pinchArea.pinch.minimumScale)
                newScale = Math.min(newScale, pinchArea.pinch.maximumScale)
                if (newScale != pinchArea.scale) {
                    pinchArea.scale = newScale
                }
                wheel.accepted = true
            } else {
                wheel.accepted = false
            }
        }
        propagateComposedEvents: true
    }
}
