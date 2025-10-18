# ######################################################################################################################
# CMAKE
# ######################################################################################################################
message(STATUS "======================================================================================================")
message(STATUS "CMAKE_VERSION       = ${CMAKE_VERSION}")
message(STATUS "CMAKE_COMMAND       = ${CMAKE_COMMAND}")
message(STATUS "CMAKE_GENERATOR     = ${CMAKE_GENERATOR}")
message(STATUS "CMAKE_CTEST_COMMAND = ${CMAKE_CTEST_COMMAND}")
message(STATUS "CMAKE_CPACK_COMMAND = ${CMAKE_CPACK_COMMAND}")
message(STATUS "======================================================================================================")

# ######################################################################################################################
# CMAKE自定义模块
# ######################################################################################################################
include(cmake/DebugFunctions.cmake)

# ######################################################################################################################
# 项目设置
# ######################################################################################################################
cmake_minimum_required(VERSION 3.18)
get_filename_component(PROJECT_FOLDER_PATH ${CMAKE_CURRENT_LIST_FILE} PATH)
get_filename_component(PROJECT_FOLDER_NAME ${PROJECT_FOLDER_PATH} NAME)
project(${PROJECT_FOLDER_NAME} VERSION 1.0.0 LANGUAGES CXX)

# ######################################################################################################################
# 编译参数
# ######################################################################################################################
# 指定C语言标准
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

# 指定C++语言标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# 其他编译选项
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# 设置默认编译类型为RelWithDebInfo
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# ######################################################################################################################
# 编译器选项
# ######################################################################################################################
add_compile_options(-Wall)
add_compile_options(-Wextra)
add_compile_options(-Wpedantic)

# ######################################################################################################################
# 依赖库
# ######################################################################################################################
include(ExternalProject)
set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_SOURCE_DIR}/external_projects)

# FMT
set(FMT_INSTALL_DIR "${CMAKE_SOURCE_DIR}/libs/libfmt-v9.1.0")
ExternalProject_Add(ep_fmt
  GIT_REPOSITORY https://github.com/fmtlib/fmt.git
  GIT_TAG 9.1.0
  GIT_SHALLOW ON
  UPDATE_DISCONNECTED ON
  INSTALL_DIR ${FMT_INSTALL_DIR}
  CMAKE_ARGS
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON
  -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
  -DFMT_TEST=OFF
)

# ######################################################################################################################
# 目标
# ######################################################################################################################
file(GLOB_RECURSE SRC_FILES ${CMAKE_SOURCE_DIR}/sources/*.cpp)

foreach(SRC_FILE ${SRC_FILES})
  get_filename_component(TARGET_NAME ${SRC_FILE} NAME_WE)
  add_executable(${TARGET_NAME} ${SRC_FILE})

  add_dependencies(${TARGET_NAME} ep_fmt)
  target_include_directories(${TARGET_NAME} PRIVATE ${FMT_INSTALL_DIR}/include)
  target_link_libraries(${TARGET_NAME} PRIVATE ${FMT_INSTALL_DIR}/lib/libfmt.a)
endforeach()