import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
Popup {
    id: datePickerPopup
    width: 350
    height: 450
    modal: true
    focus: true
    anchors.centerIn: Overlay.overlay
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    property date selectedDate: new Date()
    signal dateSelected(date selectedDate)

    // Внутренние свойства для хранения месяца и года (0-11 для месяца)
    property int currentMonth: selectedDate.getMonth()     // 0-11
    property int currentYear: selectedDate.getFullYear()

    onOpened: {
        currentMonth = selectedDate.getMonth()
        currentYear = selectedDate.getFullYear()
    }

    ColumnLayout {
        id: editDatePopupColumnLayout
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10

        Text {
            text: "Выберите дату"
            font.pixelSize: 18
            font.bold: true
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        // Навигация по месяцам
        RowLayout {
            Layout.fillWidth: true
            spacing: 15

            Button {
                text: "◀"
                onClicked: {
                    // Переход на предыдущий месяц
                    if (currentMonth === 0) {
                        currentMonth = 11
                        currentYear--
                    } else {
                        currentMonth--
                    }
                    // Обновляем MonthGrid
                    monthGrid.month = currentMonth
                    monthGrid.year = currentYear
                }
            }

            Text {
                id: monthYearText
                text: {
                    var months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
                                 "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
                    return months[currentMonth] + " " + currentYear
                }
                font.pixelSize: 18
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }

            Button {
                text: "▶"
                onClicked: {
                    // Переход на следующий месяц
                    if (currentMonth === 11) {
                        currentMonth = 0
                        currentYear++
                    } else {
                        currentMonth++
                    }
                    // Обновляем MonthGrid
                    monthGrid.month = currentMonth
                    monthGrid.year = currentYear
                }
            }
        }

        // Дни недели
        DayOfWeekRow {
            locale: Qt.locale("ru_RU")
            Layout.fillWidth: true
            delegate: Text {
                text: model.shortName
                font.bold: true
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                color: "#666"
            }
        }

        // Сетка дней
        MonthGrid {
            id: monthGrid
            month: currentMonth    // 0-11
            year: currentYear
            Layout.fillWidth: true
            Layout.fillHeight: true

            delegate: Rectangle {
                width: monthGrid.cellWidth
                height: monthGrid.cellHeight
                color: {
                    if (model.date.getTime() === selectedDate.getTime()) return "#3498db"
                    if (model.today) return "#e0e0e0"
                    return "transparent"
                }
                radius: 20

                Text {
                    text: model.day
                    anchors.centerIn: parent
                    color: model.date.getTime() === selectedDate.getTime() ? "white" : "black"
                    font.bold: model.date.getTime() === selectedDate.getTime() || model.today
                }

                MouseArea {
                    anchors.fill: parent


                    onClicked: {
                        customNote.dateTimeToCompletion = model.date
                        datePickerPopup.dateSelected(selectedDate)
                        editNoteTimePopup.open()

                        datePickerPopup.close()

                    }
                }
            }
        }

        Button {
            text: "Сегодня"
            Layout.fillWidth: true
            onClicked: {
                selectedDate = new Date()
                currentMonth = selectedDate.getMonth()
                currentYear = selectedDate.getFullYear()
                monthGrid.month = currentMonth
                monthGrid.year = currentYear
            }
        }

        Button {
            text: "Отмена"
            Layout.fillWidth: true
            onClicked: datePickerPopup.close()
        }
        Button {
            text: "Очистить дату"
            Layout.fillWidth: true
            onClicked:{
                var newDateTime = new Date(1000, 0, 1, 0, 0)
                customNote.dateTimeToCompletion = newDateTime
                if (notesBlock)
                    notesBlock.sortNotes()
                datePickerPopup.close()
            }
        }
    }
}