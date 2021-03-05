cmake_minimum_required(VERSION 3.1)
project(Natron VERSION 2.3.15)

list (APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_AUTOMOC ON)

find_package(Qt5 COMPONENTS Core Widgets Concurrent Network OpenGL REQUIRED)
find_package(Python COMPONENTS Development REQUIRED)
find_package(Boost COMPONENTS thread system REQUIRED)
find_package(OpenGL REQUIRED)
find_package(Cairo REQUIRED)
find_package(PySide2 REQUIRED)
find_package(Shiboken2 REQUIRED)

add_compile_definitions("NATRON_BUILD_NUMBER=0")

add_subdirectory(libs)
add_subdirectory(App)
add_subdirectory(Engine)
add_subdirectory(Global)
add_subdirectory(Gui)
