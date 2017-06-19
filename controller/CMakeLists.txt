cmake_minimum_required(VERSION 2.8.12)

project(controller CXX)

set(TARGET_NAME "controller")

include("${HUMOTO_INSTALL_DIR}/share/humoto/HumotoConfig.cmake")

include_directories("${HUMOTO_INSTALL_DIR}/include/")
include_directories("${HUMOTO_INCLUDES}")

set(SOURCES
    controller.cpp
    controller.h
   )

add_executable(${TARGET_NAME} ${SOURCES})
target_link_libraries(controller ${HUMOTO_LIBRARIES})
install(TARGETS ${TARGET_NAME} DESTINATION "${CMAKE_INSTALL_PREFIX}/bin/controller/")
