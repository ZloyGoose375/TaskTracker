#ifndef PLACE_H
#define PLACE_H

#include <QString>
#include <QObject>

class Place : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double latitude READ latitude WRITE setLatitude NOTIFY markerChanged)
    Q_PROPERTY(double longitude READ longitude WRITE setLongitude NOTIFY markerChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY markerChanged)
    Q_PROPERTY(bool isMarked READ isMarked WRITE setIsMarked NOTIFY markerChanged)

public:
    explicit Place(QObject *parent = nullptr);
    Place(double Latitude, double Longitude, const QString& Title, bool IsMarked, QObject *parent = nullptr);

    Place(const Place&) = delete;
    Place& operator=(const Place&) = delete;

    double latitude() const {return m_latitude;}
    double longitude() const {return m_longitude;}
    QString title() const {return m_title;}
    bool isMarked() const {return m_isMarked;}

    void setLatitude(double Latitude);
    void setLongitude(double Longitude);
    void setTitle(const QString& Title);
    void setIsMarked(bool IsMarked);

signals:
    void markerChanged();
    void markerSaved();


private:
    QPointF screenToGeo(const QPointF& ScreenPos);
    QPointF geoToScreen(double Latitude, double Longitude);

    double m_latitude;
    double m_longitude;
    QString m_title;
    bool m_isMarked;

};

#endif // PLACE_H
