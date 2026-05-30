import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {

    id: root

    property var currentNotesBlock
    property int maxVisibleNotes: 5

    signal openRequested(var block)

    // =========================
    // ВАЖНО: правильная высота
    // =========================
    implicitHeight: contentColumn.implicitHeight + 20
    height: visible ? implicitHeight : 0
    opacity: visible ? 1 : 0

    padding: 0

    background: Rectangle {
        color: "white"
        radius: 14
        border.color: "#d0d0d0"
    }

    contentItem: ColumnLayout {

        id: contentColumn

        width: parent.width
        anchors.margins: 10
        spacing: 6

        // =========================
        // ЗАГОЛОВОК
        // =========================

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

        // =========================
        // СПИСОК ЗАМЕТОК
        // =========================

        Column {

            id: notesColumn

            width: parent.width
            spacing: 2

            Repeater {

                model: currentNotesBlock ? currentNotesBlock.count : 0

                delegate: Item {

                    required property int index

                    property var note:
                        currentNotesBlock
                        ? currentNotesBlock.getNote(index)
                        : null

                    visible: note && !note.isComplete && index < maxVisibleNotes

                    width: parent.width

                    // =========================
                    // ВАЖНО: фикс высоты
                    // =========================
                    height: visible ? noteText.implicitHeight + 4 : 0

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
                            id: noteText

                            width: parent.width - 20

                            text: note ? note.title : ""

                            font.pixelSize: 14
                            color: "#333"

                            wrapMode: Text.WordWrap
                            elide: Text.ElideRight
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