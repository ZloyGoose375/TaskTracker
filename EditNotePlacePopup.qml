import QtQuick
import QtLocation
import QtPositioning
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
Popup {
    id: mapWidget

    // ДОБАВИТЬ
    parent: Overlay.overlay

    // ОСТАВИТЬ
    x: 0
    y: 0

    // ИЗМЕНИТЬ
    width: parent.width
    height: parent.height

    padding: 0
    modal: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    Component.onCompleted: {
        mapWidget.x = 0
        mapWidget.y = 0
        console.log("Popup позиция:", mapWidget.x, mapWidget.y)


        if (customNote.placeOfPerformance.isMarked) {

            mapWidget.contentItem.markerVisible = true
        }
        else{
            mapWidget.contentItem.markerVisible = true
        }
    }


    background: Rectangle {
        color: "transparent"
    }

    contentItem: Item {
        anchors.fill: parent

        property var markerCoord: QtPositioning.coordinate(customNote.placeOfPerformance.latitude, customNote.placeOfPerformance.longitude)
        property var mapCenter: QtPositioning.coordinate(53.900, 27.567)
        property bool markerVisible: false
        property var currentPlace: null

        signal markerPlaced(double lat, double lon)
        signal closed()

        Plugin {
            id: osmPlugin
            name: "osm"
        }

        Map {
            id: mapView
            anchors.fill: parent
            plugin: osmPlugin
            center: mapWidget.contentItem.mapCenter
            zoomLevel: 12
            copyrightsVisible: false

            minimumTilt: 0
            maximumTilt: 0

            MapQuickItem {
                id: markerItem
                coordinate: mapWidget.contentItem.markerCoord
                anchorPoint.x: markerImage.width / 2
                anchorPoint.y: markerImage.height
                visible: mapWidget.contentItem.markerVisible

                sourceItem: Rectangle {
                    id: markerImage
                    width: 30
                    height: 30
                    color: "red"
                    radius: 15
                    border.color: "white"
                    border.width: 2

                    Text {
                        anchors.centerIn: parent
                        text: "📍"
                        font.pixelSize: 16
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton
                        onClicked: {
                            mapWidget.contentItem.markerVisible = false
                        }
                    }
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent

                acceptedButtons: Qt.LeftButton | Qt.RightButton

                property point pressPos: Qt.point(0, 0)
                property bool wasDragged: false

                onPressed: (mouse) => {
                    if (mouse.button === Qt.LeftButton) {
                        pressPos = Qt.point(mouse.x, mouse.y)
                        wasDragged = false
                        mouse.accepted = true
                    }
                }

                onPositionChanged: (mouse) => {
                    if (mouse.buttons & Qt.LeftButton) {
                        if (Math.abs(mouse.x - pressPos.x) > 5 || Math.abs(mouse.y - pressPos.y) > 5) {
                            wasDragged = true

                            var centerPixel = mapView.fromCoordinate(mapView.center, false)
                            var dx = mouse.x - pressPos.x
                            var dy = mouse.y - pressPos.y
                            var newCenterPixel = Qt.point(centerPixel.x - dx, centerPixel.y - dy)
                            var newCenter = mapView.toCoordinate(newCenterPixel, false)
                            mapWidget.contentItem.mapCenter = newCenter

                            pressPos = Qt.point(mouse.x, mouse.y)
                        }
                        mouse.accepted = true
                    }
                }

                onReleased: (mouse) => {
                    if (mouse.button === Qt.LeftButton) {
                        if (!wasDragged) {
                            var coord = mapView.toCoordinate(Qt.point(mouse.x, mouse.y))
                            mapWidget.contentItem.markerCoord = coord
                            mapWidget.contentItem.markerVisible = true
                            mapWidget.contentItem.markerPlaced(coord.latitude, coord.longitude)

                            if (mapWidget.contentItem.currentPlace) {
                                mapWidget.contentItem.currentPlace.latitude = coord.latitude
                                mapWidget.contentItem.currentPlace.longitude = coord.longitude
                            }
                            console.log("Маркер поставлен на:", coord.latitude, coord.longitude)
                        }
                        mouse.accepted = true
                    }
                }

                onWheel: (wheel) => {
                    let zoomStep = wheel.angleDelta.y / 120
                    let newZoom = mapView.zoomLevel + zoomStep
                    if (newZoom >= mapView.minimumZoomLevel && newZoom <= mapView.maximumZoomLevel) {
                        mapView.zoomLevel = newZoom
                    }
                    wheel.accepted = true
                }
            }
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 20
            spacing: 15
            z: 1

            Rectangle {
                width: 100
                height: 40
                color: "#2196F3"
                radius: 5

                Text {
                    anchors.centerIn: parent
                    text: "Центр"
                    color: "white"
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mapWidget.contentItem.mapCenter = QtPositioning.coordinate(53.900, 27.567)
                        mapView.zoomLevel = 12
                    }
                }
            }

            Rectangle {
                width: 100
                height: 40
                color: "#FF9800"
                radius: 5

                Text {
                    anchors.centerIn: parent
                    text: "Закрыть"
                    color: "white"
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        customNote.placeOfPerformance.latitude = mapWidget.contentItem.markerCoord.latitude
                        customNote.placeOfPerformance.longitude = mapWidget.contentItem.markerCoord.longitude
                        if (mapWidget.contentItem.markerVisible) {
                            customNote.placeOfPerformance.isMarked = true
                        } else {
                            customNote.placeOfPerformance.isMarked = false
                        }
                        mapWidget.close()
                    }
                }
            }

            Rectangle {
                width: 110
                height: 40
                color: "#f44336"
                radius: 5

                Text {
                    anchors.centerIn: parent
                    text: "Очистить"
                    color: "white"
                    font.pixelSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mapWidget.contentItem.markerVisible = false
                        console.log("Маркер скрыт")
                    }
                }
            }
        }
    }
}