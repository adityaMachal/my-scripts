cmake_minimum_required(VERSION 3.10)
project(MyScripts C)

# Set the output directory for all binaries
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

# Include directory for headers
include_directories(include)

# Standard C utilities
add_executable(mmkdir src/mmkdir.c)
add_executable(touch src/touch.c)

# Installation logic (Optional for CMake, but good practice)
install(TARGETS mmkdir touch DESTINATION bin)
