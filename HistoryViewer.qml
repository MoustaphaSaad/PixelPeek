import QtQuick
import QtQuick.Layouts
import PixelPeek
import "Utils.js" as Utils

ListView {
    model: Driver.historyImageList
    spacing: 2
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
                    text: name
                }
                Text {
                    id: timestampText
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    text: Utils.timeDifference(new Date(), timestamp)
                }
                Timer {
                    interval: 1000
                    repeat: true
                    running: true
                    onTriggered: timestampText.text = Utils.timeDifference(new Date(), timestamp)
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }
}
