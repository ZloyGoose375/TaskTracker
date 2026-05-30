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
    }

    BlockOfNotesOpenButton {

        currentNotesBlock: notesBlock
        visible: !root.blockOpened

        onOpenRequested: {

            root.blockOpened = true

            blockLoader.setSource("BlockOfNotesWidget.qml", {
                notesBlock: notesBlock,

                onBackRequested: function() {
                    root.blockOpened = false
                    blockLoader.source = ""
                }
            })
        }
    }
}
