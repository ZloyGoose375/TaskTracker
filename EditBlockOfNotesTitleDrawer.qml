import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
Drawer{
    id: editBlockOfNotesTitleDrawer
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
        TextField{
            id: editBlockOfNotesTitleDrawerTextField
            Layout.fillWidth: true
            placeholderText: "Заголовок"
            text: notesBlock.blockName
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