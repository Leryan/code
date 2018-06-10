project (Pluggy)

option (WITH_PLUGGY_PLUGINS_STATIC "Build with static plugins list" OFF)
if (WITH_PLUGGY_PLUGINS_STATIC)
    set (PLUGGY_PLUGINS_STATIC 1)
elseif(NOT WITH_PLUGGY_PLUGINS_STATIC)
    set (PLUGGY_PLUGINS_STATIC 0)
endif()

configure_file (config.h.in ${CMAKE_CURRENT_SOURCE_DIR}/config.h)

AUX_SOURCE_DIRECTORY (. PROJECT_SOURCES)

include_directories (../LibPlugin)

add_executable (${PROJECT_NAME} ${PROJECT_SOURCES})

target_link_libraries (${PROJECT_NAME} LibPlugin)
