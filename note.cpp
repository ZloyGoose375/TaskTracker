#include "note.h"

Note::Note(QObject *parent)
    : QObject(parent)
    , m_title("Пустая заметка")
    , m_description("")
    , m_dateTimeToCompletion(QDateTime::currentDateTime())
    , m_placeOfPerformance(new Place(55.751244, 37.618423, "Москва", false))
    , m_isComplete(false)
{
    qDebug() << "Note создан (пустой)";
}

Note::Note(const QString& Title, const QString& Description,
           const QDateTime& DateTimeToCompletion, Place* PlaceOfPerformance, bool IsComplete,
           QObject *parent)
    : QObject(parent)
    , m_title(Title)
    , m_description(Description)
    , m_dateTimeToCompletion(DateTimeToCompletion)
    , m_placeOfPerformance(PlaceOfPerformance)
    , m_isComplete(IsComplete)
{
    qDebug() << "Note создан с данными:" << m_title;
}

void Note::setTitle(const QString& title)
{
    if (m_title != title) {
        m_title = title;
        emit titleChanged();
        qDebug() << "Title изменен на:" << m_title;
    }
}

void Note::setDescription(const QString& description)
{
    if (m_description != description) {
        m_description = description;
        emit descriptionChanged();
        qDebug() << "Description изменен";
    }
}

void Note::setDateTimeToCompletion(const QDateTime& dateTime)
{
    if (m_dateTimeToCompletion != dateTime) {
        m_dateTimeToCompletion = dateTime;
        emit dateTimeChanged();
        qDebug() << "DateTime изменен";
    }
}

void Note::setIsComplete(bool complete)
{
    if (m_isComplete != complete) {
        m_isComplete = complete;
        emit completeChanged();
        qDebug() << "Complete изменен на:" << m_isComplete;
    }
}

void Note::setPlaceOfPerformance(Place* placeOfPerformance)
{
    if (m_placeOfPerformance != placeOfPerformance) {
        m_placeOfPerformance = placeOfPerformance;
        emit placeOfPerformanceChanged();
        qDebug() << "PlaceOfPerformance изменен";
    }
}