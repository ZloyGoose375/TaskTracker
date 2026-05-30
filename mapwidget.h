#ifndef MAPWIDGET_H
#define MAPWIDGET_H

#include <QQuickPaintedItem>
#include <QPainter>
#include <QMouseEvent>
#include "place.h"

class MapWidget : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(Place* selectedPlace READ selectedPlace WRITE setSelectedPlace NOTIFY selectedPlaceChanged)
    Q_PROPERTY(bool hasSelection READ hasSelection NOTIFY selectedPlaceChanged)

public:
    explicit MapWidget(QQuickItem *parent = nullptr);
    ~MapWidget();

    void paint(QPainter *painter) override;

    Place* selectedPlace() const { return m_selectedPlace; }
    bool hasSelection() const { return m_selectedPlace != nullptr; }

    void setSelectedPlace(Place* place);

    Q_INVOKABLE void setMarker(double lat, double lon);
    Q_INVOKABLE void clearMarker();
    Q_INVOKABLE void savePlace();
    Q_INVOKABLE void searchAddress(const QString& address);
    Q_INVOKABLE void setCenter(double lat, double lon, int zoom = 1000);

signals:
    void selectedPlaceChanged();
    void placeSaved(Place* place);
    void markerMoved(double lat, double lon);

protected:
    void mousePressEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;
    void mouseReleaseEvent(QMouseEvent *event) override;

private:
    QPointF screenToGeo(const QPointF& screenPos);
    QPointF geoToScreen(double lat, double lon);
    void updateMarkerFromScreen(const QPointF& screenPos);

    Place* m_selectedPlace;
    bool m_isDragging;
    double m_zoomLevel;
    double m_centerLat;
    double m_centerLon;
};

#endif // MAPWIDGET_H