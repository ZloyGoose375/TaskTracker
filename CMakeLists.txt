cmake_minimum_required(VERSION 3.21)

project(TaskTracker VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml)
find_package(Qt6 REQUIRED COMPONENTS Location Positioning)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appTaskTracker
    main.cpp
)

qt_add_qml_module(appTaskTracker
    URI TaskTracker
    QML_FILES
        Main.qml
        SOURCES note.h note.cpp
        SOURCES
        SOURCES place.h place.cpp
        SOURCES human.h human.cpp
        SOURCES importantdate.h importantdate.cpp
        SOURCES notesblock.h notesblock.cpp
        SOURCES
        QML_FILES
        QML_FILES NoteWidget.qml
        QML_FILES EditNoteDrawer.qml
        QML_FILES
        QML_FILES EditNoteTimePopup.qml
        QML_FILES EditNoteDatePopup.qml
        QML_FILES EditNotePlacePopup.qml
        SOURCES mapwidget.h mapwidget.cpp
        QML_FILES
        QML_FILES
        QML_FILES
        QML_FILES BlockOfNotesWidget.qml
        QML_FILES
        QML_FILES EditBlockOfNotesTitleDrawer.qml
        QML_FILES BlockOfNotesOpenButton.qml
        SOURCES notesmanager.h notesmanager.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appTaskTracker PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTaskTracker
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTaskTracker PRIVATE Qt6::Core Qt6::Quick Qt6::Qml Qt6::Location Qt6::Positioning)

install(TARGETS appTaskTracker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
