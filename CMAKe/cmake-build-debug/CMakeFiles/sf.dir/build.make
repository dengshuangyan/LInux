# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.18

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /tmp/tmp.93VxkBXYAA

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /tmp/tmp.93VxkBXYAA/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/sf.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/sf.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/sf.dir/flags.make

CMakeFiles/sf.dir/safe.cpp.o: CMakeFiles/sf.dir/flags.make
CMakeFiles/sf.dir/safe.cpp.o: ../safe.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/tmp/tmp.93VxkBXYAA/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/sf.dir/safe.cpp.o"
	/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/sf.dir/safe.cpp.o -c /tmp/tmp.93VxkBXYAA/safe.cpp

CMakeFiles/sf.dir/safe.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sf.dir/safe.cpp.i"
	/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /tmp/tmp.93VxkBXYAA/safe.cpp > CMakeFiles/sf.dir/safe.cpp.i

CMakeFiles/sf.dir/safe.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sf.dir/safe.cpp.s"
	/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /tmp/tmp.93VxkBXYAA/safe.cpp -o CMakeFiles/sf.dir/safe.cpp.s

# Object files for target sf
sf_OBJECTS = \
"CMakeFiles/sf.dir/safe.cpp.o"

# External object files for target sf
sf_EXTERNAL_OBJECTS =

sf: CMakeFiles/sf.dir/safe.cpp.o
sf: CMakeFiles/sf.dir/build.make
sf: CMakeFiles/sf.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/tmp/tmp.93VxkBXYAA/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable sf"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sf.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/sf.dir/build: sf

.PHONY : CMakeFiles/sf.dir/build

CMakeFiles/sf.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/sf.dir/cmake_clean.cmake
.PHONY : CMakeFiles/sf.dir/clean

CMakeFiles/sf.dir/depend:
	cd /tmp/tmp.93VxkBXYAA/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /tmp/tmp.93VxkBXYAA /tmp/tmp.93VxkBXYAA /tmp/tmp.93VxkBXYAA/cmake-build-debug /tmp/tmp.93VxkBXYAA/cmake-build-debug /tmp/tmp.93VxkBXYAA/cmake-build-debug/CMakeFiles/sf.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/sf.dir/depend
