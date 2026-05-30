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
    Connections {
        target: blockLoader.item

        function onBackRequested() {
            blockLoader.source = ""
            root.blockOpened = false
        }
    }
    ScrollView {

        anchors.fill: parent

        Column {

            width: parent.width

            spacing: 20

            Repeater {

                model: notesBlocks

                delegate: BlockOfNotesOpenButton {

                    currentNotesBlock: modelData

                    visible: !root.blockOpened

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
}
