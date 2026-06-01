import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property date currentMonth: new Date()
    property date selectedDate: new Date()
    property bool tasksOpened: false
    property int refreshHack: 0
    Connections {
        target: notesManager
        function onTasksChanged() {
            // принудительно обновляем календарь
            root.forceLayout()
        }
    }
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 10

        // =========================
        // HEADER (фиксированный)
        // =========================

        Rectangle {
            Layout.fillWidth: true
            height: 60
            radius: 12
            color: "#2b2b2b"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Button {
                    Layout.preferredWidth: 50   // 🔥 фикс ширина
                    Layout.fillWidth: false

                    text: "◀"

                    background: Rectangle {
                        color: "#444"
                        radius: 8
                    }

                    contentItem: Text {
                        text: "◀"
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        currentMonth = new Date(
                            currentMonth.getFullYear(),
                            currentMonth.getMonth() - 1,
                            1
                        )
                    }
                }

                Label {
                    Layout.fillWidth: true

                    text: Qt.formatDate(currentMonth, "MMMM yyyy")

                    color: "white"
                    font.pixelSize: 18
                    font.bold: true

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Button {
                    Layout.preferredWidth: 50   // 🔥 фикс ширина
                    Layout.fillWidth: false

                    text: "▶"

                    background: Rectangle {
                        color: "#444"
                        radius: 8
                    }

                    contentItem: Text {
                        text: "▶"
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        currentMonth = new Date(
                            currentMonth.getFullYear(),
                            currentMonth.getMonth() + 1,
                            1
                        )
                    }
                }
            }
        }

        // =========================
        // ДНИ НЕДЕЛИ (по центру)
        // =========================

        RowLayout {
            Layout.fillWidth: true

            Repeater {
                model: ["Пн","Вт","Ср","Чт","Пт","Сб","Вс"]

                Label {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: modelData
                    font.bold: true
                    color: "#555"
                }
            }
        }

        // =========================
        // КАЛЕНДАРЬ
        // =========================

        GridLayout {
            columns: 7
            Layout.fillWidth: true

            property int daysInMonth: {
                let d = new Date(
                    currentMonth.getFullYear(),
                    currentMonth.getMonth() + 1,
                    0
                )
                return d.getDate()
            }

            Repeater {
                model: 42

                delegate: Item {

                    property int day: index + 1
                    visible: day <= parent.daysInMonth

                    width: 40
                    height: 45

                    // =========================
                    // ДЕНЬ (центрированный)
                    // =========================

                    Rectangle {
                        anchors.centerIn: parent
                        width: 36
                        height: 36
                        radius: 8

                        color: {
                            let isSelected =
                                selectedDate.getDate() === day &&
                                selectedDate.getMonth() === currentMonth.getMonth()

                            return isSelected ? "#4CAF50" : "#f2f2f2"
                        }

                        border.color: "#ddd"

                        Label {
                            anchors.centerIn: parent
                            text: parent.parent.day

                            color: parent.color === "#4CAF50"
                                   ? "white"
                                   : "black"
                        }

                        // =========================
                        // ТОЧКА (есть задачи)
                        // =========================

                        Rectangle {
                            width: 6
                            height: 6
                            radius: 3
                            color: "red"

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 3

                            visible: notesManager.hasTasksOnDate(
                                new Date(
                                    currentMonth.getFullYear(),
                                    currentMonth.getMonth(),
                                    parent.parent.day
                                )
                            )
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                selectedDate = new Date(
                                    currentMonth.getFullYear(),
                                    currentMonth.getMonth(),
                                    parent.parent.day
                                )

                                tasksOpened = true
                            }
                        }
                    }
                }
            }
        }
    }

    // =========================
    // POPUP ЗАДАЧ
    // =========================

    Popup {
        id: tasksPopup

        modal: true
        focus: true

        width: root.width
        height: root.height

        background: Rectangle {
            color: "white"
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            RowLayout {
                Layout.fillWidth: true

                Label {
                    Layout.fillWidth: true
                    text: Qt.formatDate(selectedDate, "dd.MM.yyyy")
                    font.pixelSize: 22
                    font.bold: true
                }

                Button {
                    text: "✕"
                    onClicked: tasksOpened = false
                }
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                model: notesManager.tasksForDate(selectedDate)

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 55

                    radius: 8
                    border.width: 1
                    border.color: "#ddd"

                    Label {
                        anchors.centerIn: parent
                        text: modelData.title
                    }
                }
            }
        }

        onVisibleChanged: {
            if (tasksOpened) open()
            else close()
        }
    }

    onTasksOpenedChanged: {
        if (tasksOpened)
            tasksPopup.open()
        else
            tasksPopup.close()
    }

}






//import QtQuick
//import QtQuick.Controls
//import QtQuick.Layouts
//
//Item {
//
//    anchors.fill: parent
//
//    property int daysInMonth: 30
//    property int selectedDay: -1
//
//    ColumnLayout {
//
//        anchors.fill: parent
//        anchors.margins: 20
//
//        spacing: 10
//
//        Label {
//            text: "Июнь 2026"
//
//            font.pixelSize: 24
//            font.bold: true
//        }
//
//        GridLayout {
//
//            columns: 7
//
//            rowSpacing: 5
//            columnSpacing: 5
//
//            Repeater {
//
//                model: daysInMonth
//
//                delegate: Rectangle {
//
//                    required property int index
//
//                    width: 60
//                    height: 60
//
//                    radius: 8
//
//                    color: notesManager.hasTasksOnDate(
//                               new Date(2026, 5, index + 1)
//                           )
//                           ? "#81C784"
//                           : "#f0f0f0"
//
//                    border.color: "#cccccc"
//
//                    Label {
//
//                        anchors.centerIn: parent
//
//                        text: index + 1
//                    }
//
//                    MouseArea {
//
//
//                        anchors.fill: parent
//
//                        onClicked: {
//
//                            selectedDay = index + 1
//
//                            console.log("Выбран день:", selectedDay)
//                        }
//                    }
//                }
//            }
//        }
//        Label {
//
//            visible: selectedDay > 0
//
//            text: "Выбран день: " + selectedDay
//
//            font.pixelSize: 18
//            font.bold: true
//        }
//    }
//}