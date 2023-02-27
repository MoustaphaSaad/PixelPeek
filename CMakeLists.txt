cmake_minimum_required(VERSION 3.16)

project(PixelPeek VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick QuickControls2 REQUIRED)

qt_add_executable(appPixelPeek
    main.cpp
)

qt_add_qml_module(appPixelPeek
    URI PixelPeek
    VERSION 1.0
    QML_FILES
        main.qml
        ImageViewer.qml
        AppBar.qml
        ImageUrlBox.qml
    RESOURCES
        transparent-tile.png
        icons8-folder.svg
        icons8-picture.svg
        icons8-pixel.png
)

set_target_properties(appPixelPeek PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appPixelPeek
    PRIVATE Qt6::Quick Qt6::QuickControls2)

install(TARGETS appPixelPeek
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
