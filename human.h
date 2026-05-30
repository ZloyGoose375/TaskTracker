#ifndef HUMAN_H
#define HUMAN_H

#include <QString>
#include <QDateTime>
#include <QVector>
#include "importantdate.h"
#include "place.h"

class Human
{
public:
    //не надо добавлять даты, надо добавить метод по добавлению дат
    Human(
        QString Name,
        QString Information,
        QString LikeThings,
        QString DontLikeThings,
        //Place PlaceOfResidence,
        QString PhoneNumber,
        QString Email,
        QString Telegram,
        QString Instagram,
        int RealtionshipLevel
        );
    QString name;
    QString information;
    QVector<ImportantDate> importantDates;
    QString likeThings;
    QString dontLikeThings;
    //Place& placeOfResidence;
    QString phoneNumber;
    QString email;
    QString telegram;
    QString instagram;
    int relationshipLevel;
};

#endif // HUMAN_H
