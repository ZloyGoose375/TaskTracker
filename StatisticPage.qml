import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property int refreshCounter: 0

    Connections {
        target: notesManager

        function onTasksChanged() {
            refreshCounter++
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 10

        // HEADER
        Rectangle {
            Layout.fillWidth: true
            height: 60
            radius: 10
            color: "#2b2b2b"

            Text {
                anchors.centerIn: parent
                text: "Невыполненные задачи"
                color: "white"
                font.pixelSize: 20
                font.bold: true
            }
        }

        // СПИСОК
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            contentWidth: width
            contentHeight: column.implicitHeight

            Column {
                id: column
                width: parent.width
                spacing: 10

                Repeater {
                    id: tasksRepeater

                    model: {
                        refreshCounter
                        return notesManager.allUncompletedTasks()
                    }

                    delegate: NoteWidget {
                        width: column.width * 0.95

                        anchors.horizontalCenter: parent.horizontalCenter

                        customNote: modelData
                    }
                }
            }
        }
    }
}