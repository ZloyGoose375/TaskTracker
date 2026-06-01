import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

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
                    model: notesManager.allUncompletedTasks()

                    delegate: NoteWidget {
                        width: parent.width * 0.95
                        anchors.horizontalCenter: parent.horizontalCenter

                        customNote: modelData
                    }
                }
            }
        }
    }
}