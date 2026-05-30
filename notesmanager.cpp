#include "notesmanager.h"
#include "notesblock.h"

NotesManager::NotesManager(QObject *parent)
    : QObject(parent)
{
}

void NotesManager::addBlock(const QString &name)
{
    auto *block = new NotesBlock(name, this);

    m_blocks.append(block);

    emit blocksChanged();
}

QObject* NotesManager::getBlock(int index) const
{
    if (index < 0 || index >= m_blocks.size())
        return nullptr;

    return m_blocks.at(index);
}

int NotesManager::count() const
{
    return m_blocks.size();
}

QList<QObject*> NotesManager::blocks() const
{
    return m_blocks;
}

void NotesManager::addBlockObject(QObject *block)
{
    if (!block)
        return;

    m_blocks.append(block);

    emit blocksChanged();
}