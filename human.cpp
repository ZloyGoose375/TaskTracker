#include "human.h"

Human::Human(
    QString Name,
    QString Information,
    QString LikeThings,
    QString DontLikeThings,
    //Place PlaceOfResidence,
    QString PhoneNumber,
    QString Email,
    QString Telegram,
    QString Instagram,
    int RelationshipLevel
    )
{
    name = Name;
    information = Information;
    likeThings = LikeThings;
    dontLikeThings = DontLikeThings;
    //placeOfResidence = PlaceOfResidence;
    phoneNumber = PhoneNumber;
    email = Email;
    telegram = Telegram;
    instagram = Instagram;
    relationshipLevel = RelationshipLevel;
    importantDates = QVector<ImportantDate>();
}
