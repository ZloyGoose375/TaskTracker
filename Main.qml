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
        console.log("BLOCK COUNT =", notesManager.count())
        console.log("BLOCKS =", notesManager.blocks)
    }
    property bool blockOpened: false

    Loader {
        id: blockLoader
        anchors.fill: parent
    }

    Item {
        anchors.fill: parent
        visible: blockLoader.source === ""

        Column {
            anchors.fill: parent
            spacing: 10

            Button {
                text: "+ Новый блок"

                onClicked: {
                    notesManager.addBlock("Новый блок")
                }
            }

            ScrollView {
                anchors.fill: parent
                clip: true   // 🔥 ВАЖНО

                Column {
                    width: parent.width   // ❗ ТОЛЬКО width
                    spacing: 10

                    Repeater {
                        model: notesManager.blocks

                        delegate: BlockOfNotesOpenButton {
                            width: parent.width
                            currentNotesBlock: modelData

                            onOpenRequested: {
                                blockLoader.setSource(
                                    "BlockOfNotesWidget.qml",
                                    { notesBlock: currentNotesBlock }
                                )
                            }
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: blockLoader.item

        function onBackRequested() {
            blockLoader.source = ""
        }
    }
}
