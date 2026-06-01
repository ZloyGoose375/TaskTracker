#ifndef NOTESMANAGER_H
#define NOTESMANAGER_H
#include <QObject>
#include <QVector>

#include "notesblock.h"

class NotesManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QList<QObject*> blocks READ blocks NOTIFY blocksChanged)

public:
    explicit NotesManager(QObject *parent = nullptr);

    Q_INVOKABLE void addBlock(const QString &name);
    Q_INVOKABLE QObject* getBlock(int index) const;
    Q_INVOKABLE int count() const;
    Q_INVOKABLE void addBlockObject(QObject *block);
    Q_INVOKABLE void removeBlock(QObject *block);
    Q_INVOKABLE bool hasTasksOnDate(QDate date);
    Q_INVOKABLE QVariantList tasksForDate(const QDate &date);

    QList<QObject*> blocks() const;

signals:
    void tasksChanged();
    void blocksChanged();

private:
    QList<QObject*> m_blocks;
};

#endif // NOTESMANAGER_H
