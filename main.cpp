#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QList>
#include "mapwidget.h"
#include "place.h"
#include "note.h"
#include "notesblock.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<MapWidget>("MapModule", 1, 0, "MapWidget");
    qmlRegisterType<Place>("MapModule", 1, 0, "Place");

    qmlRegisterType<MapWidget>("MapModule", 1, 0, "MapWidget");

    QQmlApplicationEngine engine;

    QList<NotesBlock> blocks = new QList<NotesBlock()>;
    NotesBlock* notesBlock = new NotesBlock("АААААААААААА");
    NotesBlock* notesBlock2 = new NotesBlock("NotesBlock2");
    NotesBlock* notesBlock3 = new NotesBlock("NotesBlock3");

    Place* testPlace = new Place(50, 40, "Москва", true);
    QDateTime testDateTime = QDateTime::currentDateTime();
    Note *testNote1 = new Note(
        "Проверка текста 0",
        "a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a ",
        testDateTime,
        testPlace,
        false
    );
    Note *testNote2 = new Note(
        "Проверка текста 1",
        "a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a ",
        testDateTime,
        testPlace,
        false
    );
    Note *testNote3 = new Note();
    Note *testNote4 = new Note();
    Note *testNote5 = new Note();
    Note *testNote6 = new Note();

    notesBlock->addNote(testNote1);
    notesBlock->addNote(testNote2);
    notesBlock2->addNote(testNote3);
    notesBlock2->addNote(testNote4);
    notesBlock3->addNote(testNote5);
    notesBlock3->addNote(testNote6);

    blocks.append(notesBlock);
    blocks.append(notesBlock2);
    blocks.append(notesBlock3);

    engine.rootContext()->setContextProperty("notesBlock", notesBlock);
    engine.load(QUrl::fromLocalFile("TaskTracker/Main.qml"));

    if (engine.rootObjects().isEmpty()) {
        qDebug() << "ОШИБКА: main.qml не загружен";
        return -1;
    }

    return app.exec();
}
