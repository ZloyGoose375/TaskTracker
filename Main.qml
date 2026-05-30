import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
Window {
    id: root

    width: 640
    height: 480
    visible: true
    Component.onCompleted: {
        console.log("BLOCKS =", notesManager.blocks)
    }
    property bool blockOpened: false

    // ================================
    // ЭКРАН БЛОКА (Loader)
    // ================================

    Loader {
        id: blockLoader
        anchors.fill: parent
    }

    // ================================
    // ГЛАВНЫЙ ЭКРАН (СПИСОК БЛОКОВ)
    // ================================

    Column {

        anchors.fill: parent
        spacing: 10

        // =========================
        // КНОПКА ДОБАВЛЕНИЯ
        // =========================

        Button {
            text: "+ Новый блок"

            width: parent.width
            height: 45

            onClicked: {
                notesManager.addBlock("Новый блок")
            }
        }

        // =========================
        // СПИСОК БЛОКОВ
        // =========================

        Repeater {

            model: notesManager.blocks   // ВАЖНО!

            delegate: BlockOfNotesOpenButton {

                width: parent.width

                currentNotesBlock: modelData

                onOpenRequested: {

                    root.blockOpened = true

                    blockLoader.setSource(
                        "BlockOfNotesWidget.qml",
                        {
                            notesBlock: currentNotesBlock
                        }
                    )
                }
            }
        }
    }

    // ================================
    // ОБРАБОТКА BACK ИЗ БЛОКА
    // ================================

    Connections {
        target: blockLoader.item

        function onBackRequested() {

            root.blockOpened = false
            blockLoader.source = ""
        }
    }
}
