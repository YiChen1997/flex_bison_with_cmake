cmake_minimum_required(VERSION 3.8)

set(PROJECT_NAME bisontest)
project(${PROJECT_NAME})
set(CMAKE_CXX_STANDARD 11)

include(cmake/flex_bison.cmake)

FLEX_TARGET(MyScanner ${CMAKE_SOURCE_DIR}/calc.l  ${CMAKE_CURRENT_BINARY_DIR}/lexical.cpp)
BISON_TARGET(MyParser ${CMAKE_SOURCE_DIR}/calc.y ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp)

message(STATUS "FLEX_TARGET_outputs: ${FLEX_TARGET_outputs}")
message(STATUS "BISON_TARGET_outputs: ${BISON_TARGET_outputs}")

add_executable(${PROJECT_NAME} ${FLEX_TARGET_outputs} ${BISON_TARGET_outputs})

target_link_libraries(${PROJECT_NAME} 
    PUBLIC ${FLEX_LIBRARIES}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC ${CMAKE_CURRENT_BINARY_DIR}
    PUBLIC ${CMAKE_CURRENT_LIST_DIR}
)