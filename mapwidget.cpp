#include "mapwidget.h"
#include <QDebug>
#include <QMouseEvent>

MapWidget::MapWidget(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , m_selectedPlace(nullptr)
    , m_isDragging(false)
    , m_zoomLevel(1000.0)
    , m_centerLat(55.751244)
    , m_centerLon(37.618423)
{
    setAcceptedMouseButtons(Qt::LeftButton);
    setRenderTarget(QQuickPaintedItem::FramebufferObject);
    setWidth(600);
    setHeight(400);
    setOpaquePainting(true);

    qDebug() << "MapWidget создан";
}

MapWidget::~MapWidget()
{
}

void MapWidget::paint(QPainter *painter)
{
    if (!painter) return;

    // Фон
    painter->fillRect(boundingRect(), QColor(220, 230, 240));

    // Сетка
    painter->setPen(QPen(QColor(180, 190, 200), 1));
    for (int x = 0; x < width(); x += 50) {
        painter->drawLine(x, 0, x, height());
    }
    for (int y = 0; y < height(); y += 50) {
        painter->drawLine(0, y, width(), y);
    }

    // Маркер
    if (m_selectedPlace) {
        QPointF screenPos = geoToScreen(m_selectedPlace->latitude(),
                                        m_selectedPlace->longitude());

        painter->setBrush(QBrush(QColor(255, 82, 82)));
        painter->setPen(QPen(Qt::white, 2));
        painter->drawEllipse(screenPos, 12, 12);

        painter->setBrush(QBrush(Qt::white));
        painter->drawEllipse(screenPos, 5, 5);
    }
}

void MapWidget::setSelectedPlace(Place* place)
{
    if (m_selectedPlace != place) {
        m_selectedPlace = place;
        emit selectedPlaceChanged();
        update();
    }
}

void MapWidget::setMarker(double lat, double lon)
{
    if (!m_selectedPlace) {
        m_selectedPlace = new Place(lat, lon, "Новое место", this);
    } else {
        m_selectedPlace->setLatitude(lat);
        m_selectedPlace->setLongitude(lon);
        m_selectedPlace->setTitle("Новое место");
        m_selectedPlace->setIsMarked(true);
    }

    emit selectedPlaceChanged();
    emit markerMoved(lat, lon);
    update();
    qDebug() << "Маркер установлен на:" << lat << "," << lon;
}

void MapWidget::clearMarker()
{
    if (m_selectedPlace) {
        m_selectedPlace = nullptr;
        emit selectedPlaceChanged();
        update();
        qDebug() << "Маркер очищен";
    }
}

void MapWidget::savePlace()
{
    if (m_selectedPlace) {
        emit placeSaved(m_selectedPlace);
        qDebug() << "Место сохранено:" << m_selectedPlace->title();
    }
}

void MapWidget::searchAddress(const QString& address)
{
    qDebug() << "Поиск адреса:" << address;

    if (address.contains("кремль", Qt::CaseInsensitive)) {
        setMarker(55.751244, 37.618423);
        setCenter(55.751244, 37.618423);
    } else if (address.contains("мгу", Qt::CaseInsensitive)) {
        setMarker(55.703791, 37.530542);
        setCenter(55.703791, 37.530542);
    } else {
        qDebug() << "Адрес не найден:" << address;
    }
}

void MapWidget::setCenter(double lat, double lon, int zoom)
{
    m_centerLat = lat;
    m_centerLon = lon;
    if (zoom > 0) m_zoomLevel = zoom;
    update();
    qDebug() << "Центр установлен на:" << lat << "," << lon;
}

void MapWidget::mousePressEvent(QMouseEvent *event)
{
    if (!event) return;
    m_isDragging = true;
    updateMarkerFromScreen(event->pos());
}

void MapWidget::mouseMoveEvent(QMouseEvent *event)
{
    if (!event || !m_isDragging || !(event->buttons() & Qt::LeftButton)) return;
    updateMarkerFromScreen(event->pos());
}

void MapWidget::mouseReleaseEvent(QMouseEvent *event)
{
    Q_UNUSED(event)
    m_isDragging = false;
}

void MapWidget::updateMarkerFromScreen(const QPointF& screenPos)
{
    QPointF geoPos = screenToGeo(screenPos);
    setMarker(geoPos.y(), geoPos.x());
}

// ===== ВАЖНО: РЕАЛИЗАЦИИ ЭТИХ МЕТОДОВ =====
QPointF MapWidget::screenToGeo(const QPointF& screenPos)
{
    double lon = m_centerLon + (screenPos.x() - width()/2) / m_zoomLevel;
    double lat = m_centerLat + (screenPos.y() - height()/2) / m_zoomLevel;
    return QPointF(lon, lat);
}

QPointF MapWidget::geoToScreen(double lat, double lon)
{
    double x = width()/2 + (lon - m_centerLon) * m_zoomLevel;
    double y = height()/2 + (lat - m_centerLat) * m_zoomLevel;
    return QPointF(x, y);
}