#include "place.h"
#include <QMouseEvent>
#include <QDebug>

Place::Place(QObject *parent) : QObject(parent), m_latitude(1), m_longitude(1), m_title("Точка"), m_isMarked(true){
    qDebug() << "Создана точка заглушка";
}

Place::Place(double Latitude, double Longitude, const QString& Title, bool IsMarked, QObject *parent): QObject(parent), m_latitude(Latitude), m_longitude(Longitude), m_title(Title), m_isMarked(IsMarked){
    qDebug() << "Создалась точка";
}

void Place::setLatitude(double Latitude)
{
    if (qFuzzyCompare(m_latitude, Latitude))
        return;

    m_latitude = Latitude;
    emit markerChanged();
    qDebug() << "Широта изменена:" << m_latitude;
}

void Place::setLongitude(double Longitude)
{
    if (qFuzzyCompare(m_longitude, Longitude))
        return;

    m_longitude = Longitude;
    emit markerChanged();
    qDebug() << "Долгота изменена:" << m_longitude;
}

void Place::setTitle(const QString& Title)
{
    if (m_title == Title)
        return;

    m_title = Title;
    emit markerChanged();
    qDebug() << "Название изменено:" << m_title;
}

void Place::setIsMarked(bool IsMarked)
{
    if (m_isMarked == IsMarked)
        return;

    m_isMarked = IsMarked;
    emit markerChanged();
    qDebug() << "Статус отметки:" << (m_isMarked ? "отмечено" : "не отмечено");
}


