cmake_minimum_required(VERSION 2.8.12)

project(controller-template CXX)

include(ExternalProject)

set(CMAKE_MODULE_PATH      "${PROJECT_SOURCE_DIR}/cmake/")

set(HUMOTO_DIR             "${PROJECT_SOURCE_DIR}/humoto")
set(HUMOTO_INSTALL_DIR     "${PROJECT_BINARY_DIR}/humoto_install")
set(CONTROLLER_CONFIG_PATH "${PROJECT_BINARY_DIR}/config")

set(SUBPORJECT_ARGS
    -DCMAKE_VERBOSE_MAKEFILE=ON
    -DCMAKE_BUILD_TYPE=Release)
if(CMAKE_TOOLCHAIN_FILE)
    set(SUBPORJECT_ARGS
        ${SUBPORJECT_ARGS}
        "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}")
endif(CMAKE_TOOLCHAIN_FILE)

set(HUMOTO_CMAKE_ARGS
    "-C${PROJECT_SOURCE_DIR}/cmake/humoto.cmake"
    ${SUBPORJECT_ARGS}
    "-DCMAKE_INSTALL_PREFIX=${HUMOTO_INSTALL_DIR}"
    "-DCMAKE_CXX_FLAGS=-fPIC -Wno-error=conversion -Wno-error=unused-parameter -Wno-unused-parameter")

include(CMakeParseArguments)
include(humoto_add_external_git_project)
humoto_add_external_git_project(TARGET_NAME "humoto"
                                PROJECT_DIR "${HUMOTO_DIR}"
                                CMAKE_ARGS   ${HUMOTO_CMAKE_ARGS})

set(CONTROLLER_INSTALL_DIR "${PROJECT_BINARY_DIR}/controller_install/")
set(CONTROLLER_CMAKE_ARGS
    ${SUBPORJECT_ARGS}
    "-DHUMOTO_INSTALL_DIR=${HUMOTO_INSTALL_DIR}"
    "-DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}"
    "-DCMAKE_INSTALL_PREFIX=${CONTROLLER_INSTALL_DIR}"
    "-DCMAKE_CXX_FLAGS=-fPIC -Wno-error=conversion -Wno-error=unused-parameter -Wno-unused-parameter")

ExternalProject_Add(
    controller
    SOURCE_DIR "${PROJECT_SOURCE_DIR}/controller/"
    CMAKE_ARGS  ${CONTROLLER_CMAKE_ARGS}
)

add_dependencies(controller humoto)
