cmake_minimum_required(VERSION 3.18)

project(RobotArm LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 COMPONENTS Gui Qml Quick)
qt_add_executable(RobotArmApp src/main.cpp)

target_link_libraries(RobotArmApp PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Qml
)

qt6_add_qml_module(RobotArmApp
    URI "Main"
    VERSION 1.0
    NO_PLUGIN
    QML_FILES main.qml
)

add_subdirectory(content)
add_subdirectory(backend)

qt_add_library(RobotArm STATIC)
qt6_add_qml_module(RobotArm
    URI "RobotArm"
    VERSION 1.0)

set(QML_IMPORT_PATH
    ${CMAKE_BINARY_DIR}
    CACHE STRING "")

target_link_libraries(RobotArmApp PRIVATE
    contentplugin
    RobotArmplugin
    backend
)
