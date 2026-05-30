#ifndef IMPORTANTDATE_H
#define IMPORTANTDATE_H

#include <QDateTime>
#include <QString>

class ImportantDate
{
public:
    ImportantDate(QDateTime date, QString title);
    QDateTime date;
    QString title;
};

#endif // IMPORTANTDATE_H
