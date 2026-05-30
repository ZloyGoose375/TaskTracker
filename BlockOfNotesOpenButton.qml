import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {

    id: root

    property var currentNotesBlock
    property int maxVisibleNotes: 5

    signal openRequested(var block)

    implicitWidth: 320
    implicitHeight: 220

    padding: 0

    background: Rectangle {
        color: "white"
        radius: 14
        border.color: "#d0d0d0"
    }

    contentItem: ColumnLayout {

        anchors.fill: parent
        anchors.margins: 10
        spacing: 6

        Label {

            text: currentNotesBlock
                  ? currentNotesBlock.blockName
                  : "Блок заметок"

            font.pixelSize: 22
            font.bold: true

            color: "black"

            Layout.fillWidth: true

            horizontalAlignment: Text.AlignHCenter

            elide: Text.ElideRight
            wrapMode: Text.NoWrap
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#e0e0e0"
        }

        Repeater {

            model: currentNotesBlock ? currentNotesBlock.count : 0

            delegate: Item {

                property int index: model.index
                property var note: currentNotesBlock.getNote(index)

                visible: note && !note.isComplete && index < maxVisibleNotes

                width: parent.width
                height: visible ? text.implicitHeight : 0

                Row {

                    width: parent.width
                    spacing: 5

                    Rectangle {
                        width: 7
                        height: 7
                        radius: 4
                        color: "#2196F3"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        id: text

                        text: note ? note.title : ""

                        width: parent.width - 20

                        font.pixelSize: 14
                        color: "#333"
                        elide: Text.ElideRight
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }
    }

    onClicked: {

        if (!currentNotesBlock)
            return

        console.log("Открытие блока:", currentNotesBlock.blockName)

        openRequested(currentNotesBlock)
    }
}