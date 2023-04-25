cmake_minimum_required(VERSION 3.16)

project(PixelPeek VERSION 0.1.4 LANGUAGES CXX)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_INSTALL_RPATH "$ORIGIN")
set(CMAKE_BUILD_RPATH "$ORIGIN")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

configure_file(PixelPeek.rc.in ${CMAKE_CURRENT_BINARY_DIR}/PixelPeek.rc)

set(OS_FILES)
if (WIN32)
    set(OS_FILES ${CMAKE_CURRENT_BINARY_DIR}/PixelPeek.rc)
endif (WIN32)

qt_add_executable(appPixelPeek
    main.cpp
    ImageWatcher.h
    Driver.h
    ${OS_FILES}
)

qt_add_qml_module(appPixelPeek
    URI PixelPeek
    VERSION 1.0
    QML_FILES
        Main.qml
        ImageViewer.qml
        AppBar.qml
        ImageUrlBox.qml
        PopWindow.qml
        StatusBar.qml
        Utils.js
    RESOURCES
        transparent-tile.png
        icons8-folder.svg
        icons8-picture.svg
        icons8-pixel.png
        icons8-restore.png
        icons8-picture-94.png
)

set_target_properties(appPixelPeek PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    OUTPUT_NAME "PixelPeek"
)

target_link_libraries(appPixelPeek
    PRIVATE Qt6::Quick Qt6::QuickControls2)

install(TARGETS appPixelPeek
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

target_include_directories(appPixelPeek
    PUBLIC
    ${CMAKE_CURRENT_BINARY_DIR}/include
)

configure_file(BuildInfo.h.in ${CMAKE_CURRENT_BINARY_DIR}/include/BuildInfo.h)

