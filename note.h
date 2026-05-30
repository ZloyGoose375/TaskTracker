#ifndef NOTE_H
#define NOTE_H

#include <QObject>
#include <QString>
#include <QDateTime>
#include <QVector>
#include "place.h"
#include "human.h"

class Note : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QDateTime dateTimeToCompletion READ dateTimeToCompletion WRITE setDateTimeToCompletion NOTIFY dateTimeChanged)
    Q_PROPERTY(bool isComplete READ isComplete WRITE setIsComplete NOTIFY completeChanged)
    Q_PROPERTY(Place* placeOfPerformance READ placeOfPerformance WRITE setPlaceOfPerformance NOTIFY placeOfPerformanceChanged)

public:
    // Конструкторы
    explicit Note(QObject *parent = nullptr);
    Note(const QString& Title, const QString& Description,
         const QDateTime& DateTimeToCompletion, Place* PlaceOfPerformance, bool IsComplete,
         QObject *parent = nullptr);

    // Геттеры
    QString title() const { return m_title; }
    QString description() const { return m_description; }
    QDateTime dateTimeToCompletion() const { return m_dateTimeToCompletion; }
    bool isComplete() const { return m_isComplete; }
    Place* placeOfPerformance() const { return m_placeOfPerformance; }

    // Сеттеры
    void setTitle(const QString& title);
    void setDescription(const QString& description);
    void setDateTimeToCompletion(const QDateTime& dateTime);
    void setIsComplete(bool complete);
    void setPlaceOfPerformance(Place* placeOfPerformance);

signals:
    void titleChanged();
    void descriptionChanged();
    void dateTimeChanged();
    void completeChanged();
    void placeOfPerformanceChanged();

private:
    QString m_title;
    QString m_description;
    QDateTime m_dateTimeToCompletion;
    Place* m_placeOfPerformance;
    bool m_isComplete = false;
};
#endif // NOTE_H
