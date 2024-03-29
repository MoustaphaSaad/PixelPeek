import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import PixelPeek
import "Utils.js" as Utils

ListView {
    id: list
    model: Driver.historyImageList
    spacing: 2
    currentIndex: Driver.historyImageList.selectedImageIndex
    ScrollBar.vertical: ScrollBar {}
    focus: true
    activeFocusOnTab: true
    Keys.onPressed: function (event) {
        Utils.handleKeyNav(Driver, event)
    }
    delegate: Rectangle {
        width: ListView.view.width
        height: 60
        color: {
            if (index === list.currentIndex)
                return "#A0D8B3"
            else if (index % 2 === 0)
                return "#D3DCE4"
            else
                return "#E7ECF0"
        }

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
                    onTriggered: timestampText.text = Utils.timeDifference(
                                     new Date(), timestamp)
                }
            }

            Item {
                Layout.fillWidth: true
            }
        }

        MouseArea {
            anchors {
                fill: parent
            }
            onClicked: Driver.historyImageList.selectedImageIndex = index
        }
    }

    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        onClicked: function (mouse) {
            parent.forceActiveFocus()
            mouse.accepted = false
        }
    }
}
