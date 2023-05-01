import QtQuick
import QtQuick.Layouts
import PixelPeek

ListView {
    model: Driver.historyImageCount
    spacing: 4
    delegate: Rectangle {
        width: ListView.view.width
        height: 60
        color: index % 2 === 0 ? "#D3DCE4" : "#E7ECF0"

        RowLayout {
            anchors {
                fill: parent
                margins: 4
            }
            clip: true

            Image {
                Layout.fillHeight: true
                Layout.preferredWidth: paintedWidth
                fillMode: Image.PreserveAspectFit
                source: `image://history/${index}`
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "blue"
            }
        }
    }
}
