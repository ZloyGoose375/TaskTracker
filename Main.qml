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
    Flickable {
        id: flick
        anchors.fill: parent
        clip: true

        visible: !blockLoader.item

        contentWidth: width
        contentHeight: columnRoot.implicitHeight

        Column {
            id: columnRoot
            width: parent.width
            spacing: 10

            Button {
                text: "+ Новый блок"
                width: parent.width
                height: 45

                onClicked: notesManager.addBlock("Новый блок")
            }

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


    Connections {
        target: blockLoader.item

        function onBackRequested() {
            console.log("BACK CLICKED")

            blockLoader.source = ""   // только это
        }
    }
    Connections {
        target: blockLoader

        function onSourceChanged() {
            if (blockLoader.source === "") {
                console.log("BACK TO MAIN")

                Qt.callLater(function() {
                    flick.contentHeight = columnRoot.childrenRect.height
                })
            }
        }
    }
}
