# winbinsonflex编译参考：https://github.com/lexxmark/winflexbison/issues/69

# BISON_TARGET 与 FLEX_TARGET 参考：https://github.com/LonghronShen/xy-compiler/tree/feature/runtime/cmake

find_program(BISON_EXECUTABLE NAMES bison win_bison DOC "path to the bison executable")
if(BISON_EXECUTABLE)
    message(STATUS "FOUND BISON_EXECUTABLE IN: ${BISON_EXECUTABLE}")
else()
    message(WARNING "BISON_EXECUTABLE not found, set BISON_EXECUTABLE manually")
    set(BISON_EXECUTABLE "C:/Program Files/winflexbison/win_bison.exe")
endif()


find_program(FLEX_EXECUTABLE NAMES flex win_flex DOC "path to the bison executable")
if(FLEX_EXECUTABLE)
    message(STATUS "FOUND FLEX_EXECUTABLE IN: ${FLEX_EXECUTABLE}")
else()
    message(WARNING "FLEX_EXECUTABLE not found, set FLEX_EXECUTABLE manually")
    set(FLEX_EXECUTABLE "C:/Program Files/winflexbison/win_flex.exe")
endif()
message("")

macro(BISON_TARGET Name BisonInput BisonOutput)
    set(BISON_TARGET_outputs "${BisonOutput}")
    set(_BisonInput "${BisonInput}")

    get_filename_component(BISON_EXECUTABLE_DIR ${BISON_EXECUTABLE} DIRECTORY)
      set(BISON_EXECUTABLE_DIR "${BISON_EXECUTABLE_DIR}/data")

    add_custom_command(OUTPUT ${BISON_TARGET_outputs}
        COMMAND  ${CMAKE_COMMAND} -E env BISON_PKGDATADIR=${BISON_EXECUTABLE_DIR} ${BISON_EXECUTABLE} -o ${BisonOutput} -H ${_BisonInput}
    )
endmacro()

macro(FLEX_TARGET Name Input Output)
    set(FLEX_TARGET_outputs "${Output}")
    add_custom_command(OUTPUT ${FLEX_TARGET_outputs}
        COMMAND ${FLEX_EXECUTABLE} -o${Output} ${Input}
    )
  endmacro()