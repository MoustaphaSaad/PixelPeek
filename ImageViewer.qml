import QtQuick

Flickable {
    contentWidth: image.implicitWidth
    contentHeight: image.implicitHeight

    PinchArea {
        anchors {
            fill: parent
        }
        //        pinch.target: image
        pinch.maximumScale: 10
        pinch.minimumScale: 0.1
        pinch.dragAxis: Pinch.XAndYAxis
        onPinchStarted: function (pinch) {
            console.log(pinch.scale)
        }
        onSmartZoom: function (pinch) {
            console.log("smart zoom")
        }

        Image {
            id: image
            source: "https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?cs=srgb&dl=pexels-pixabay-45201.jpg&fm=jpg"
        }
    }
}
