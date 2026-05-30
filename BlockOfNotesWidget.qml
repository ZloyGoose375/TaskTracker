import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    // =========================================
    // Внешний вид
    // =========================================
    property var notesBlock
    color: "#f5f5f5"

    radius: 12

    border.color: "#d0d0d0"
    border.width: 1

    implicitWidth: 500
    implicitHeight: 700

    signal backRequested()
    // =========================================
    // Контейнер
    // =========================================

    ColumnLayout {
        anchors.fill: parent

        anchors.margins: 15

        spacing: 15

        // =====================================
        // Верхняя панель
        // =====================================

        RowLayout {

            Layout.fillWidth: true

            spacing: 10

            // =================================
            // Название блока
            // =================================
            Button{
                implicitWidth: 40
                implicitHeight: 40

                background: Rectangle {
                    color: "#4CAF50"
                    radius: 6
                }

                contentItem: Text {
                    text: "<"
                    color: "white"
                    font.pixelSize: 24

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    console.log("BACK CLICKED")
                    backRequested()
                }
            }

            Label {

                text: notesBlock
                      ? notesBlock.blockName
                      : "Блок заметок"

                font.pixelSize: 22
                font.bold: true

                color: "black"

                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            Button{
                implicitWidth: 40
                implicitHeight: 40

                background: Rectangle {
                    color: "#4CAF50"
                    radius: 6
                }

                contentItem: Text {
                    text: "✎"
                    color: "white"
                    font.pixelSize: 24

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                EditBlockOfNotesTitleDrawer{
                    id: editBlockOfNotesTitleDrawer
                }

                onClicked: {
                    editBlockOfNotesTitleDrawer.open()
                }
            }

            // =================================
            // Количество заметок
            // =================================

            Label {

                text: notesBlock
                      ? "Заметок: " + notesBlock.count
                      : ""

                font.pixelSize: 14

                color: "#555555"
            }

            // =================================
            // Кнопка добавления
            // =================================

            Button {

                implicitWidth: 40
                implicitHeight: 40

                background: Rectangle {
                    color: "#4CAF50"
                    radius: 6
                }

                contentItem: Text {
                    text: "+"
                    color: "white"
                    font.pixelSize: 24

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {

                    notesBlock.addNote(
                                "Новая заметка",
                                "",
                                new Date(1000, 0, 1, 0, 0),
                                null,
                                false
                                )
                }
            }
        }

        // =====================================
        // Список заметок
        // =====================================

        ScrollView {

            Layout.fillWidth: true
            Layout.fillHeight: true

            clip: true

            ListView {
                id: notesListView

                anchors.fill: parent

                spacing: 15

                model: notesBlock
                       ? notesBlock.notes
                       : null

                delegate: NoteWidget {

                    width: notesListView.width

                    customNote: modelData
                }
            }

            Connections {

                target: notesBlock

                function onCountChanged() {

                    notesListView.model = null
                    notesListView.model = notesBlock.notes
                }
            }
        }
    }
}
