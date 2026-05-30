import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root



    // =========================================
    // Текущая заметка из NotesBlock
    // =========================================

    property var customNote

    // =========================================
    // Дата
    // =========================================

    property date noteDateTimeЖ: customNote ? customNote.dateTimeToCompletion : new Date(1000, 0, 1, 0, 0)
    property var fictionDateTime: new Date(1000, 0, 1, 0, 0)
    property date noteDateTime

    // =========================================
    // Внешний вид
    // =========================================

    implicitWidth: 400

    implicitHeight: columnNoteWidgetContainer.implicitHeight + 30

    color: "white"

    border.color: "#cccccc"
    border.width: 1

    radius: 10

    Component.onCompleted: {

        console.log(customNote.dateTimeToCompletion)
    }
    // =========================================
    // Контейнер
    // =========================================

    ColumnLayout {
        id: columnNoteWidgetContainer

        anchors.fill: parent

        anchors.margins: 15

        spacing: 20

        // =====================================
        // Верхняя строка
        // =====================================

        RowLayout {
            id: rowNoteWidgetContainer

            Layout.fillWidth: true

            spacing: 10

            // =================================
            // Редактирование текста
            // =================================

            Button {
                id: editTitleAndDescriptionNoteWidgetButton

                implicitWidth: 30
                implicitHeight: 30

                Layout.preferredWidth: 30

                background: Rectangle {
                    color: "black"
                    radius: 4
                }

                contentItem: Text {
                    text: "✎"
                    color: "white"
                    font.pixelSize: 16

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                EditNoteDrawer {
                    id: editNoteDrawer
                }

                onClicked: {
                    editNoteDrawer.open()
                }
            }

            // =================================
            // Заголовок
            // =================================

            Label {
                id: titleNoteWidgetLabel

                text: customNote
                      ? customNote.title
                      : ""

                color: "black"

                font.pixelSize: 16
                font.bold: true

                verticalAlignment: Text.AlignVCenter

                Layout.fillWidth: true

                elide: Text.ElideRight
            }

            // =================================
            // Дата
            // =================================

            Label {
                id: dateTimeNoteWidgetLabel

                visible: customNote && customNote.dateTimeToCompletion && customNote.dateTimeToCompletion.getTime() !== fictionDateTime.getTime()

                text: Qt.formatDateTime(customNote.dateTimeToCompletion, "dd.MM.yy HH:mm")


                color: "black"
                font.pixelSize: 14
            }

            // =================================
            // Карта
            // =================================

            Button {
                id: editPlaceNoteWidgetButton

                implicitWidth: 30
                implicitHeight: 30

                Layout.preferredWidth: 30

                background: Rectangle {
                    color: "black"
                    radius: 4
                }

                contentItem: Text {
                    text: "🗺"
                    color: "white"
                    font.pixelSize: 16

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                EditNotePlacePopup {
                    id: editNotePlacePopup
                }

                onClicked: {
                    editNotePlacePopup.open()
                }
            }

            // =================================
            // Выполнено
            // =================================

            CheckBox {
                id: isCompleteNoteWidgetCheckBox

                implicitWidth: 30
                implicitHeight: 30

                Layout.preferredWidth: 30

                checked: customNote? customNote.isComplete : false

                onCheckedChanged: {

                    if (!customNote)
                        return

                    customNote.isComplete = checked
                }
            }

            // =================================
            // Удаление
            // =================================

            Button {
                id: deleteNoteNoteWidgetButton

                implicitWidth: 30
                implicitHeight: 30

                Layout.preferredWidth: 30

                background: Rectangle {
                    color: "black"
                    radius: 4
                }

                contentItem: Text {
                    text: "🗑"
                    color: "white"
                    font.pixelSize: 16

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {

                    if (!customNote || !notesBlock)
                        return

                    notesBlock.removeNote(customNote)
                }
            }
        }

        // =====================================
        // Описание
        // =====================================

        Label {
            id: descriptionNoteWidgetLabel

            text: customNote? customNote.description : ""

            visible: text.length > 0

            width: parent.width

            color: "black"

            font.pixelSize: 15

            wrapMode: Text.WordWrap

            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft

            Layout.fillWidth: true
            Layout.preferredHeight: implicitHeight
        }
    }
}