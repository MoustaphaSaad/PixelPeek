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

            ColumnLayout {
                Layout.fillHeight: false
                Layout.fillWidth: true
                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    text: `Image #${index}`
                }
                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    text: "5 hours ago"
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }
}
