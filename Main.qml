import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
Window {
    id: root
    property bool blockOpened: false
    width: 640
    height: 480
    visible: true
    title: qsTr("мы в дерьме")

    Loader {
        id: blockLoader
        anchors.fill: parent

        onLoaded: {
            console.log("LOADED ITEM =", item)

            if (!item)
                return

            item.backRequested.connect(function() {
                console.log("BACK RECEIVED")

                root.blockOpened = false
                blockLoader.source = ""
            })
        }
    }

    // Список кнопок (главный экран)
    Column {

        visible: !root.blockOpened

        Repeater {
            model: notesBlocks

            delegate: BlockOfNotesOpenButton {

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
}
