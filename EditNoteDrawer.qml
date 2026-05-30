import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
Drawer{
    //СДЕЛАТЬ ЧТОБЫ ДАТА ПЕРЕРПИСЫВАЛАСЬ ТОЛЬКО ЧЕРЕЗ КНОПКУ СОХРАНИТЬ
    id: editNoteDrawer
    onOpened:{
        editNoteTitleDrawerTextField.text = customNote.title
        editNoteDescriptionTextArea.text = customNote.description
    }
    width: parent.width
    implicitHeight: implicitContentHeight + 50
    edge: Qt.BottomEdge
    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        RowLayout{
            TextField{
                id: editNoteTitleDrawerTextField
                Layout.fillWidth: true
                placeholderText: "Заголовок"
                text: customNote.title
            }
            Button{
                id: eidtDateTimeDrawerButton
                EditNoteDatePopup{
                    id: editNoteDatePopup
                }
                EditNoteTimePopup{
                    id: editNoteTimePopup
                }
                onClicked:{
                    editNoteDatePopup.open()
                }
            }
        }


        TextArea{
            id: editNoteDescriptionTextArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            placeholderText: "Описание"
            text: customNote.description
            wrapMode: Text.WordWrap

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
                if (editNoteTitleDrawerTextField.text !== ""){
                    customNote.title = editNoteTitleDrawerTextField.text
                    customNote.description = editNoteDescriptionTextArea.text
                    editNoteDrawer.close()
                }
                else{
                    errorNoTitleDrawer.open()
                }
            }
        }
    }
}
