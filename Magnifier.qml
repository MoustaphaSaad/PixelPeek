import QtQuick

Image {
    id: magnify

    property rect pixelSize: Qt.size(pixelRect.width, pixelRect.height)
    required property real imageScale

    width: 200
    height: 200
    sourceSize: Qt.size(25, 25)
    fillMode: Image.Stretch
    mipmap: true
    smooth: false
    cache: false

    Rectangle {
        id: pixelRect
        color: "transparent"
        border.width: 2
        border.color: "black"
        x: (magnify.width / 2) - width / 2
        y: (magnify.height / 2) - height / 2
        width: magnify.width / magnify.sourceSize.width * imageScale
        height: magnify.height / magnify.sourceSize.height * imageScale
        Rectangle {
            color: "transparent"
            border.width: 1
            border.color: "white"
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
        }
    }
}
