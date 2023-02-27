import QtQuick
import QtQuick.Templates as T

T.Button {
    id: button

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    leftPadding: 12
    rightPadding: 12
    topPadding: 3
    bottomPadding: 3
    font.pixelSize: 13

    contentItem: Row {
        spacing: 8
        Image {
            anchors.verticalCenter: parent.verticalCenter
            sourceSize: Qt.size(14, 14)
            source: "qrc:/PixelPeek/icons8-folder.svg"
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: button.text
            font: button.font
            color: button.down ? "#464B52" : "#FFFFFF"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }

    background: Rectangle {
        opacity: enabled ? 1 : 0.5
        color: {
            if (button.down)
                return "#B4BAC4"
            else if (button.hovered)
                return "#8E97A8"
            else
                return "#7B869A"
        }
        radius: 4
    }
}
