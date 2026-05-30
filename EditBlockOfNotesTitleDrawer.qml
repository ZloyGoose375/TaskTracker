import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
Drawer{
    id: editBlockOfNotesTitleDrawer
    property var currentNotesBlock
    currentNotesBlock: notesBlock   // 🔥 ВАЖНО

    signal blockDeleted()
    onOpened:{
        editBlockOfNotesTitleDrawerTextField.text = notesBlock.blockName
    }

    width: parent.width
    implicitHeight: implicitContentHeight + 50
    edge: Qt.BottomEdge

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        RowLayout {

            width: parent.width
            spacing: 10

            // =========================
            // КНОПКА УДАЛЕНИЯ БЛОКА
            // =========================

            Button {
                implicitWidth: 40
                implicitHeight: 40

                background: Rectangle {
                    color: "#E53935"
                    radius: 6
                }

                contentItem: Text {
                    text: "🗑"
                    color: "white"
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {

                    console.log("DELETE CLICKED")

                    if (!currentNotesBlock) {
                        console.log("NO BLOCK")
                        return
                    }

                    console.log("DELETING:", currentNotesBlock.blockName)

                    // удаляем блок
                    notesManager.removeBlock(currentNotesBlock)

                    // 🔥 сообщаем наружу
                    blockDeleted()
                }
            }

            // =========================
            // ПОЛЕ ВВОДА НАЗВАНИЯ
            // =========================

            TextField {
                id: editBlockOfNotesTitleDrawerTextField

                Layout.fillWidth: true

                text: currentNotesBlock ? currentNotesBlock.blockName : ""

                placeholderText: "Название блока"

                onTextChanged: {
                    if (currentNotesBlock)
                        currentNotesBlock.blockName = text
                }
            }
        }

        Button{
            id: editTitleNoteDrawerConfirmButton
            Layout.fillWidth: true
            text: "Сохранить изменения"
            Drawer{
                id: errorNoTitleDrawer
                modal: false
                dim: false
                width: parent.width
                edge: Qt.TopEdge
                y: editNoteDrawer.y + editNoteDrawer.height
                Label{
                    id: errorNoTitleDrawerMessageLabel
                    text: "Поле 'Заголовок' пустое"
                    font.pixelSize: 16
                    width: parent.width

                }
                Timer {
                    id: closeTimer
                    interval: 1000
                    repeat: false
                    onTriggered: {
                        errorNoTitleDrawer.close()
                    }
                }
            }
            onClicked:{
                if (editBlockOfNotesTitleDrawerTextField.text !== ""){
                    notesBlock.blockName = editBlockOfNotesTitleDrawerTextField.text
                    editBlockOfNotesTitleDrawer.close()
                }
                else{
                    errorNoTitleDrawer.open()
                }
            }
        }
    }
}