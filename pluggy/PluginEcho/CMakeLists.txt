project (PluginEcho)

AUX_SOURCE_DIRECTORY (. PROJECT_SOURCES)

include_directories (../LibPlugin)

add_library(${PROJECT_NAME} SHARED ${PROJECT_SOURCES})
