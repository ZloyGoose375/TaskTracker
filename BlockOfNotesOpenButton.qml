import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Button {

    id: root

    property var currentNotesBlock
    property int maxVisibleNotes: 5

    signal openRequested(var block)

    // =========================
    // СТАБИЛЬНАЯ ВЫСОТА
    // =========================
    implicitHeight: contentColumn.implicitHeight + 16

    padding: 0

    background: Rectangle {
        color: "white"
        radius: 14
        border.color: "#d0d0d0"
    }

    contentItem: Column {

        id: contentColumn

        width: parent.width
        spacing: 6

        // =========================
        // ЗАГОЛОВОК
        // =========================
        Label {
            width: parent.width

            text: currentNotesBlock
                  ? currentNotesBlock.blockName
                  : "Блок заметок"

            font.pixelSize: 22
            font.bold: true
            color: "black"

            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }

        Rectangle {
            width: parent.width
            height: 1
            color: "#e0e0e0"
        }

        // =========================
        // ЗАМЕТКИ (ФИКС)
        // =========================
        Column {

            width: parent.width
            spacing: 4

            Repeater {

                model: currentNotesBlock ? currentNotesBlock.count : 0

                delegate: Item {

                    required property int index

                    property var note: currentNotesBlock
                                      ? currentNotesBlock.getNote(index)
                                      : null

                    width: parent.width

                    implicitHeight: row.implicitHeight

                    Row {
                        id: row
                        width: parent.width
                        spacing: 6

                        Rectangle {
                            width: 7
                            height: 7
                            radius: 4
                            color: "#2196F3"
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            width: parent.width - 20
                            text: note ? note.title : ""
                            font.pixelSize: 14
                            color: "#333"
                            wrapMode: Text.WordWrap
                        }
                    }
                }
            }
        }
    }

    // =========================
    // CLICK
    // =========================
    onClicked: {

        if (!currentNotesBlock)
            return

        console.log("Открытие блока:", currentNotesBlock.blockName)

        openRequested(currentNotesBlock)
    }
}