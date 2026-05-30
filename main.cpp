#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
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

    NotesBlock* notesBlock = new NotesBlock("АААААААААААА");

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

    notesBlock->addNote(testNote1);
    notesBlock->addNote(testNote2);


    engine.rootContext()->setContextProperty("notesBlock", notesBlock);
    engine.load(QUrl::fromLocalFile("TaskTracker/Main.qml"));

    if (engine.rootObjects().isEmpty()) {
        qDebug() << "ОШИБКА: main.qml не загружен";
        return -1;
    }

    return app.exec();
}
