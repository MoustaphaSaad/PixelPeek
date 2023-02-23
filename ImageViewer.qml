import QtQuick

Flickable {
    contentWidth: image.implicitWidth
    contentHeight: image.implicitHeight

    Image {
        id: image
        source: "https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?cs=srgb&dl=pexels-pixabay-45201.jpg&fm=jpg"
    }
}
