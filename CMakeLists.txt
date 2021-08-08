cmake_minimum_required(VERSION 3.17)
project(Linux_code)

set(CMAKE_CXX_STANDARD 14)
set(INC_DIR /usr/include)
set(LIB_DIR /usr/lib67)

include_directories(${INC_DIR})
link_directories(${LIB_DIR})
link_libraries(pthread)

#add_executable(Linux_code main.cpp)
add_executable(sf safe.cpp)
add_executable(c++ main.cpp)
add_executable(socket service.cpp client.cpp)