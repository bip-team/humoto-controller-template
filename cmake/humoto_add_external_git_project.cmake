function(humoto_add_external_git_project)
    set(options NOBUILD)
    set(oneValueArgs TARGET_NAME PROJECT_DIR)
    set(multiValueArgs CMAKE_ARGS)
    cmake_parse_arguments("HUMOTO" "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )


    find_package(Git)

    if (EXISTS "${HUMOTO_PROJECT_DIR}/.git")
        message("Found '.git' subdirectory in project '${HUMOTO_PROJECT_DIR}': skipping download step.")

        if (HUMOTO_NOBUILD)
            ExternalProject_Add(
                ${HUMOTO_TARGET_NAME}
                DOWNLOAD_DIR    "${HUMOTO_PROJECT_DIR}"
                SOURCE_DIR      "${HUMOTO_PROJECT_DIR}"
                DOWNLOAD_COMMAND    ""
                BUILD_COMMAND       ""
                INSTALL_COMMAND     ""
                CONFIGURE_COMMAND   ""
                STEP_TARGETS    download
            )
        else (HUMOTO_NOBUILD)
            ExternalProject_Add(
                ${HUMOTO_TARGET_NAME}
                DOWNLOAD_DIR    "${HUMOTO_PROJECT_DIR}"
                SOURCE_DIR      "${HUMOTO_PROJECT_DIR}"
                CMAKE_ARGS      ${HUMOTO_CMAKE_ARGS}
                DOWNLOAD_COMMAND    ""
                STEP_TARGETS    download
            )
        endif (HUMOTO_NOBUILD)
    else()
        if (GIT_FOUND)
            if (HUMOTO_NOBUILD)
                ExternalProject_Add(
                    ${HUMOTO_TARGET_NAME}
                    DOWNLOAD_DIR    "${HUMOTO_PROJECT_DIR}"
                    SOURCE_DIR      "${HUMOTO_PROJECT_DIR}"
                    DOWNLOAD_COMMAND    ${GIT_EXECUTABLE} submodule update --init --no-fetch ./
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    CONFIGURE_COMMAND   ""
                    STEP_TARGETS    download
                )
            else (HUMOTO_NOBUILD)
                ExternalProject_Add(
                    ${HUMOTO_TARGET_NAME}
                    DOWNLOAD_DIR    "${HUMOTO_PROJECT_DIR}"
                    SOURCE_DIR      "${HUMOTO_PROJECT_DIR}"
                    CMAKE_ARGS      ${HUMOTO_CMAKE_ARGS}
                    DOWNLOAD_COMMAND    ${GIT_EXECUTABLE} submodule update --init --no-fetch ./
                    STEP_TARGETS    download
                )
            endif (HUMOTO_NOBUILD)
        else(GIT_FOUND)
            message( SEND_ERROR "Cannot download project '${HUMOTO_PROJECT_DIR}' due to missing git. Checking if the files are alredy there..." )
            file(GLOB RESULT ${HUMOTO_PROJECT_DIR})
            list(LENGTH RESULT RES_LEN)
            if(RES_LEN EQUAL 0)
                message(FATAL_ERROR "Project directory '${HUMOTO_PROJECT_DIR}' is empty, compilation is impossible." )
            endif()
        endif(GIT_FOUND)
    endif()
endfunction(humoto_add_external_git_project)
