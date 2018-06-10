project (LibPlugin)

include_directories (.)

aux_source_directory (. PROJECT_SOURCES)

add_library (${PROJECT_NAME} SHARED ${PROJECT_SOURCES})

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    target_link_libraries (${PROJECT_NAME} dl)
endif()
