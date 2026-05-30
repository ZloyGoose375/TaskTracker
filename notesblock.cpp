// =========================
// notesblock.cpp
// =========================

#include "notesblock.h"

#include <QDebug>

// ===================================
// CONSTRUCTORS
// ===================================

NotesBlock::NotesBlock(QObject *parent)
    : QObject(parent)
    , m_blockName("Новый блок")
{

}

NotesBlock::NotesBlock(const QString& blockName,
                       QObject *parent)
    : QObject(parent)
    , m_blockName(blockName)
{

}

// ===================================
// QML LIST PROPERTY
// ===================================

QQmlListProperty<Note> NotesBlock::notes()
{
    return QQmlListProperty<Note>(
        this,
        this,
        &NotesBlock::appendNote,
        &NotesBlock::noteCount,
        &NotesBlock::noteAt,
        &NotesBlock::clearNotes
        );
}

void NotesBlock::appendNote(QQmlListProperty<Note>* list,
                            Note* note)
{
    NotesBlock* notesBlock =
        qobject_cast<NotesBlock*>(list->object);

    if (!notesBlock || !note)
        return;


    notesBlock->m_notes.append(note);

    emit notesBlock->countChanged();
}

qsizetype NotesBlock::noteCount(QQmlListProperty<Note>* list)
{
    NotesBlock* notesBlock =
        qobject_cast<NotesBlock*>(list->object);

    if (!notesBlock)
        return 0;

    return notesBlock->m_notes.size();
}

Note* NotesBlock::noteAt(QQmlListProperty<Note>* list,
                         qsizetype index)
{
    NotesBlock* notesBlock =
        qobject_cast<NotesBlock*>(list->object);

    if (!notesBlock)
        return nullptr;

    if (index < 0 ||
        index >= notesBlock->m_notes.size())
    {
        return nullptr;
    }

    return notesBlock->m_notes.at(index);
}

void NotesBlock::clearNotes(QQmlListProperty<Note>* list)
{
    NotesBlock* notesBlock =
        qobject_cast<NotesBlock*>(list->object);

    if (!notesBlock)
        return;

    qDeleteAll(notesBlock->m_notes);

    notesBlock->m_notes.clear();

    emit notesBlock->countChanged();
}

// ===================================
// GETTERS
// ===================================

int NotesBlock::count() const
{
    return m_notes.size();
}

QString NotesBlock::blockName() const
{
    return m_blockName;
}

// ===================================
// SETTERS
// ===================================

void NotesBlock::setBlockName(const QString& blockName)
{
    if (m_blockName == blockName)
        return;

    m_blockName = blockName;

    emit blockNameChanged();
}

// ===================================
// METHODS
// ===================================

void NotesBlock::addNote(Note* note)
{
    if (!note)
        return;

    m_notes.append(note);

    emit countChanged();
}

void NotesBlock::addNote(const QString& title,
                         const QString& description,
                         const QDateTime& dateTime,
                         Place* place,
                         bool isComplete)
{
    if (!place) {
        place = new Place(55.751244, 37.618423, "Москва", false);
    }
    Note* note =
        new Note(title,
                 description,
                 dateTime,
                 place,
                 isComplete,
                 this);

    m_notes.append(note);

    emit countChanged();
}

void NotesBlock::removeNote(int index)
{
    if (index < 0 ||
        index >= m_notes.size())
    {
        return;
    }

    Note* note = m_notes[index];

    m_notes.removeAt(index);

    note->deleteLater();

    emit countChanged();
}

Note* NotesBlock::getNote(int index) const
{
    if (index < 0 ||
        index >= m_notes.size())
    {
        return nullptr;
    }

    return m_notes[index];
}

