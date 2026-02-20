cmake_minimum_required(VERSION 3.14)

project(flightmap LANGUAGES CXX C)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (APPLE)
	set(CMAKE_MAKE_PROGRAM "/opt/local/bin/gmake")
	include_directories("/opt/local/include")
endif()

if (WIN32)
	add_definitions(-DWINDOWS)
elseif (APPLE)
	add_definitions(-DAPPLE)
elseif (UNIX)
	add_definitions(-DUNIX)
endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick Widgets Positioning REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Widgets Positioning REQUIRED)

# Threads
find_package(Threads REQUIRED)

# Main group
file (GLOB MAIN_SRC "src/main/*.cpp" "src/main/*.h")
source_group("main" FILES ${MAIN_SRC})
set (ALL_SRC ${ALL_SRC} ${MAIN_SRC})

# Common group
file (GLOB COMMON_SRC "src/common/*.cpp" "src/common/*.h")
source_group("common" FILES ${COMMON_SRC})
set (ALL_SRC ${ALL_SRC} ${COMMON_SRC})

# Devices group
file (GLOB DEVICES_SRC "src/devices/*.cpp" "src/devices/*.h")
source_group("devices" FILES ${DEVICES_SRC})
set (ALL_SRC ${ALL_SRC} ${DEVICES_SRC})

# Messages group
file (GLOB MESSAGES_SRC "src/messages/*.cpp" "src/messages/*.h")
source_group("messages" FILES ${MESSAGES_SRC})
set (ALL_SRC ${ALL_SRC} ${MESSAGES_SRC})

# Data group
file (GLOB DATA_SRC "src/data/*.cpp" "src/data/*.h")
source_group("data" FILES ${DATA_SRC})
set (ALL_SRC ${ALL_SRC} ${DATA_SRC})

# Comms group
file (GLOB COMMS_SRC "src/comms/*.cpp" "src/comms/*.h")
source_group("comms" FILES ${COMMS_SRC})
set (ALL_SRC ${ALL_SRC} ${COMMS_SRC})

# Onboard group
file (GLOB ONBOARD_SRC "src/onboard/*.cpp" "src/onboard/*.h")
source_group("onboard" FILES ${ONBOARD_SRC})
set (ALL_SRC ${ALL_SRC} ${ONBOARD_SRC})

# Sources
include_directories("src")
file(GLOB SOURCES "src/*.h" "src/*.hpp" "src/*.cpp")
add_executable(${PROJECT_NAME} ${ALL_SRC} "res/qml.qrc")

if (APPLE)
	target_include_directories(${PROJECT_NAME} PUBLIC "/opt/local/include")
endif()

# Json
target_include_directories(${PROJECT_NAME} PRIVATE "libs/jsoncpp/include")
if (WIN32)
	target_link_directories(${PROJECT_NAME} PRIVATE "libs/jsoncpp/lib/windows")
elseif (APPLE)
	target_link_directories(${PROJECT_NAME} PRIVATE "libs/jsoncpp/lib/darwin")
elseif (UNIX)
	target_link_directories(${PROJECT_NAME} PRIVATE "libs/jsoncpp/lib/linux")
endif()

# Zipper
target_include_directories(${PROJECT_NAME} PRIVATE "libs/zipper/include")
if (WIN32)
	target_link_directories(${PROJECT_NAME} PRIVATE "libs/zipper/lib/windows")
elseif (APPLE)
	target_link_directories(${PROJECT_NAME} PRIVATE "libs/zipper/lib/darwin")
elseif (UNIX)
	target_link_directories(${PROJECT_NAME} PRIVATE "libs/zipper/lib/linux")
endif()

target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${PROJECT_NAME} Threads::Threads jsoncpp zipper
	Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::Positioning)

if (WIN32)
	target_link_libraries(${PROJECT_NAME} ws2_32)
endif()
