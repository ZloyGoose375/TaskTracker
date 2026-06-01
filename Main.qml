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
    property string currentPage: "tasks"

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // =========================
        // БОКОВАЯ ПАНЕЛЬ
        // =========================

        Rectangle {
            Layout.preferredWidth: 120
            Layout.fillHeight: true

            color: "#2b2b2b"

            Column {
                anchors.fill: parent
                anchors.margins: 10

                spacing: 10

                Label {
                    width: parent.width

                    text: "TaskTracker"

                    color: "white"
                    font.pixelSize: 20
                    font.bold: true

                    horizontalAlignment: Text.AlignHCenter
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#555555"
                }

                Button {
                    width: parent.width
                    text: "📝 Задачи"
                    onClicked: {
                        currentPage = "tasks"
                    }
                }
                Button {
                    width: parent.width
                    text: "📅 Календарь"
                    onClicked: {
                        currentPage = "calendar"
                    }
                }

                Button {
                    width: parent.width
                    text: "📊 Статистика"
                }
            }
        }

        // =========================
        // ОСНОВНАЯ ОБЛАСТЬ
        // =========================

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // =========================
            // КАЛЕНДАРЬ
            // =========================

            CalendarPage {
                anchors.fill: parent

                visible: currentPage === "calendar"
            }

            // =========================
            // ОТКРЫТЫЙ БЛОК
            // =========================

            Loader {
                id: blockLoader

                anchors.fill: parent

                visible: currentPage === "tasks"
            }

            // =========================
            // СПИСОК БЛОКОВ
            // =========================

            Flickable {
                id: flick

                anchors.fill: parent

                clip: true

                visible: currentPage === "tasks"
                         && !blockLoader.item

                contentWidth: width
                contentHeight: columnRoot.implicitHeight

                Column {
                    id: columnRoot

                    width: flick.width

                    spacing: 10

                    Button {
                        text: "+ Новый блок"

                        width: parent.width
                        height: 45

                        onClicked: {
                            notesManager.addBlock("Новый блок")
                        }
                    }

                    Repeater {
                        model: notesManager.blocks

                        delegate: BlockOfNotesOpenButton {

                            width: parent.width

                            currentNotesBlock: modelData

                            onOpenRequested: {

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
