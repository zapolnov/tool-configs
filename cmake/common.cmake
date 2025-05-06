if(IGAGIS_CMAKE_COMMON_INCLUDED)
    return()
endif()
set(IGAGIS_CMAKE_COMMON_INCLUDED TRUE)

if(MSVC)
    add_definitions(
        /wd5055 # operator '*': deprecated between enumerations and floating-point types
    )
endif()

macro(add_source_directory out srcdir)
    set(options RECURSIVE)
    set(single)
    set(multiple PATTERNS)
    cmake_parse_arguments(asd "${options}" "${single}" "${multiple}" ${ARGN})

    set(glob GLOB)
    if(asd_RECURSIVE)
        set(glob GLOB_RECURSE)
    endif()

    set(patterns)
    foreach(pattern ${asd_PATTERNS})
        list(APPEND patterns "${srcdir}/${pattern}")
    endforeach()

    file(${glob} globresult RELATIVE "${srcdir}" CONFIGURE_DEPENDS ${patterns})
    foreach(file ${globresult})
        get_filename_component(path "${file}" DIRECTORY)
        string(REPLACE "/" "\\" path "Source Files/${path}")
        source_group("${path}" FILES "${srcdir}/${file}")
        list(APPEND ${out} "${srcdir}/${file}")
    endforeach()
endmacro()

macro(declare_library name)
    set(options)
    set(single INSTALL)
    set(multiple SOURCES DEPENDENCIES EXTERNAL_DEPENDENCIES
        PRIVATE_INCLUDE_DIRECTORIES PUBLIC_INCLUDE_DIRECTORIES INSTALL_INCLUDE_DIRECTORIES)
    cmake_parse_arguments(dl "${options}" "${single}" "${multiple}" ${ARGN})

    include(GNUInstallDirs)

    # Check if {NAME}_DISABLE_INSTALL variable is set and act accordingly
    string(TOUPPER "${name}" nameupper)
    string(REPLACE "-" "_" nameupper "${nameupper}")
    set(install TRUE)
    if(${nameupper}_DISABLE_INSTALL)
        set(install FALSE)
    endif()

    # Normally we create STATIC libraries and specify PUBLIC includes and dependencies.
    # For libraries with no source files this won't work, so use INTERFACE/INTERFACE instead.
    set(public INTERFACE)
    set(static INTERFACE)
    foreach(src ${dl_SOURCES})
        get_filename_component(ext "${src}" LAST_EXT)
        if("${ext}" STREQUAL ".c" OR "${ext}" STREQUAL ".cpp" OR "${ext}" STREQUAL ".cc")
            set(public PUBLIC)
            set(static STATIC)
            break()
        endif()
    endforeach()

    add_library(${name} ${static} ${dl_SOURCES})

    target_compile_features(${name} ${public} cxx_std_20)
    set_target_properties(${name} PROPERTIES CXX_STANDARD_REQUIRED ON)
    set_target_properties(${name} PROPERTIES CXX_EXTENSIONS OFF)

    foreach(dir ${dl_PUBLIC_INCLUDE_DIRECTORIES})
        target_include_directories(${name} ${public} $<BUILD_INTERFACE:${dir}>)
    endforeach()

    foreach(dir ${dl_PRIVATE_INCLUDE_DIRECTORIES})
        target_include_directories(${name} PRIVATE $<BUILD_INTERFACE:${dir}>)
    endforeach()

    foreach(dep ${dl_DEPENDENCIES})
        if(NOT TARGET ${dep}::${dep})
            find_package(${dep} CONFIG REQUIRED)
        endif()
        target_link_libraries(${name} ${public} ${dep}::${dep})
    endforeach()

    foreach(dep ${dl_EXTERNAL_DEPENDENCIES})
        if(NOT TARGET ${dep}::${dep})
            find_package(${dep} REQUIRED)
        endif()
        target_link_libraries(${name} ${public} ${dep}::${dep})
    endforeach()

    if(${install})
        target_include_directories(${name} ${public} $<INSTALL_INTERFACE:include>)
        # install library header files preserving directory hierarchy
        foreach(dir ${dl_INSTALL_INCLUDE_DIRECTORIES})
            install(
                DIRECTORY
                    "${dir}"
                DESTINATION
                    "${CMAKE_INSTALL_INCLUDEDIR}"
                FILES_MATCHING
                    PATTERN "*.h"
                    PATTERN "*.hpp"
                    PATTERN "*.hh"
            )
        endforeach()
        # generate cmake configs
        install(
            TARGETS
                ${name}
            EXPORT
                ${name}-config
        )
        # install cmake configs
        install(
            EXPORT
                ${name}-config
            FILE
                ${name}-config.cmake
            DESTINATION
                "${CMAKE_INSTALL_DATAROOTDIR}/${name}"
            NAMESPACE
                "${name}::"
        )
    endif()
endmacro()
