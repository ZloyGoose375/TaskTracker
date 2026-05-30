// =========================
// notesblock.h
// =========================

#ifndef NOTESBLOCK_H
#define NOTESBLOCK_H

#include <QObject>
#include <QList>
#include <QQmlListProperty>

#include "note.h"

    class NotesBlock : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QQmlListProperty<Note> notes
                   READ notes
                       NOTIFY countChanged)

    Q_PROPERTY(int count
                   READ count
                       NOTIFY countChanged)

    Q_PROPERTY(QString blockName
                   READ blockName
                       WRITE setBlockName
                           NOTIFY blockNameChanged)

public:

    explicit NotesBlock(QObject *parent = nullptr);

    NotesBlock(const QString& blockName,
               QObject *parent = nullptr);

    // ===================================
    // QML LIST
    // ===================================

    QQmlListProperty<Note> notes();

    static void appendNote(QQmlListProperty<Note>* list,
                           Note* note);

    static qsizetype noteCount(QQmlListProperty<Note>* list);

    static Note* noteAt(QQmlListProperty<Note>* list,
                        qsizetype index);

    static void clearNotes(QQmlListProperty<Note>* list);

    // ===================================
    // GETTERS
    // ===================================

    int count() const;

    QString blockName() const;

    // ===================================
    // SETTERS
    // ===================================

    void setBlockName(const QString& blockName);

    // ===================================
    // METHODS
    // ===================================

    Q_INVOKABLE void addNote(Note* note);

    Q_INVOKABLE void addNote(const QString& title,
                             const QString& description,
                             const QDateTime& dateTime,
                             Place* place,
                             bool isComplete = false);

    Q_INVOKABLE void removeNote(int index);

    Q_INVOKABLE Note* getNote(int index) const;

signals:

    void countChanged();

    void blockNameChanged();

private:

    QString m_blockName;

    QList<Note*> m_notes;
};

#endif // NOTESBLOCK_H



