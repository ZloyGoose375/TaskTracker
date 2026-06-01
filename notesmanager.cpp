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
    connect(block, &NotesBlock::notesChangedExternally,
            this, &NotesManager::tasksChanged);

    connect(block, &NotesBlock::countChanged,
            this, &NotesManager::tasksChanged);
    emit blocksChanged();
    emit tasksChanged();   // 🔥 ДОБАВИТЬ
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
void NotesManager::removeBlock(QObject *block)
{
    if (!block)
        return;

    m_blocks.removeAll(block);

    block->deleteLater();

    emit blocksChanged();
    emit tasksChanged();   // 🔥 ДОБАВИТЬ

    qDebug() << "BLOCK DELETED";
}
bool NotesManager::hasTasksOnDate(QDate date)
{
    for (QObject* object : m_blocks)
    {
        NotesBlock* block =
            qobject_cast<NotesBlock*>(object);

        if (!block)
            continue;

        for (int i = 0; i < block->count(); i++)
        {
            Note* note = block->getNote(i);

            if (!note)
                continue;

            if (note->dateTimeToCompletion().date() == date)
                return true;
        }
    }

    return false;
}
QVariantList NotesManager::tasksForDate(const QDate &date)
{
    QVariantList result;

    for (QObject* obj : m_blocks)
    {
        NotesBlock* block = qobject_cast<NotesBlock*>(obj);
        if (!block)
            continue;

        for (int i = 0; i < block->count(); ++i)
        {
            Note* note = block->getNote(i);
            if (!note)
                continue;

            QDate noteDate = note->dateTimeToCompletion().date();

            if (noteDate == date && !note->isComplete())
            {
                result.append(QVariant::fromValue(note));
            }
        }
    }

    return result;
}
