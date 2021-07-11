cmake_minimum_required(VERSION 3.16.3)
set(CMAKE_TOOLCHAIN_FILE ./cmake/toolchain_arm.cmake) 
PROJECT(AGameBoyRomDev)

# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

add_subdirectory(minimal)