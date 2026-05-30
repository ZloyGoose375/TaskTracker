import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: timePickerPopup
    width: 300
    height: 350
    modal: true
    focus: true
    anchors.centerIn: Overlay.overlay
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    property int selectedHour: new Date().getHours()
    property int selectedMinute: new Date().getMinutes()
    signal timeSelected(int hour, int minute)

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "Выберите время"
            font.pixelSize: 18
            font.bold: true
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        // Отображение выбранного времени
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#f0f0f0"
            radius: 10

            Text {
                id: timeDisplay
                text: {
                    var hourStr = selectedHour.toString().padStart(2, '0')
                    var minuteStr = selectedMinute.toString().padStart(2, '0')
                    return hourStr + ":" + minuteStr
                }
                font.pixelSize: 32
                font.bold: true
                anchors.centerIn: parent
            }
        }

        // Слайдер для часов
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 5

            Text {
                text: "Часы: " + selectedHour.toString().padStart(2, '0')
                font.pixelSize: 14
            }

            Slider {
                id: hourSlider
                from: 0
                to: 23
                stepSize: 1
                value: selectedHour
                Layout.fillWidth: true

                onValueChanged: {
                    selectedHour = value
                }
            }
        }

        // Слайдер для минут
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 5

            Text {
                text: "Минуты: " + selectedMinute.toString().padStart(2, '0')
                font.pixelSize: 14
            }

            Slider {
                id: minuteSlider
                from: 0
                to: 59
                stepSize: 1
                value: selectedMinute
                Layout.fillWidth: true

                onValueChanged: {
                    selectedMinute = value
                }
            }
        }

        // Кнопки
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "Сейчас"
                Layout.fillWidth: true
                onClicked: {
                    var now = new Date()
                    selectedHour = now.getHours()
                    selectedMinute = now.getMinutes()
                    hourSlider.value = selectedHour
                    minuteSlider.value = selectedMinute
                }
            }

            Button {
                text: "OK"
                Layout.fillWidth: true
                onClicked: {
                    selectedHour = hourSlider.value
                    selectedMinute = minuteSlider.value
                    var newDateTime = new Date(
                        customNote.dateTimeToCompletion.getFullYear(),
                        customNote.dateTimeToCompletion.getMonth(),
                        customNote.dateTimeToCompletion.getDate(),
                        selectedHour,
                        selectedMinute
                    )
                    customNote.dateTimeToCompletion = newDateTime
                    timePickerPopup.close()
                }
            }
        }
    }
}