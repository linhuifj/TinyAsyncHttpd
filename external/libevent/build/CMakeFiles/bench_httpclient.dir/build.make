# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.7

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/linhui/workspace/OCRService/external_src/libevent

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/linhui/workspace/OCRService/external_src/libevent/build

# Include any dependencies generated for this target.
include CMakeFiles/bench_httpclient.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/bench_httpclient.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/bench_httpclient.dir/flags.make

CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o: CMakeFiles/bench_httpclient.dir/flags.make
CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o: ../test/bench_httpclient.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/linhui/workspace/OCRService/external_src/libevent/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o   -c /home/linhui/workspace/OCRService/external_src/libevent/test/bench_httpclient.c

CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/linhui/workspace/OCRService/external_src/libevent/test/bench_httpclient.c > CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.i

CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/linhui/workspace/OCRService/external_src/libevent/test/bench_httpclient.c -o CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.s

CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o.requires:

.PHONY : CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o.requires

CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o.provides: CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o.requires
	$(MAKE) -f CMakeFiles/bench_httpclient.dir/build.make CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o.provides.build
.PHONY : CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o.provides

CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o.provides.build: CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o


# Object files for target bench_httpclient
bench_httpclient_OBJECTS = \
"CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o"

# External object files for target bench_httpclient
bench_httpclient_EXTERNAL_OBJECTS =

bin/bench_httpclient: CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o
bin/bench_httpclient: CMakeFiles/bench_httpclient.dir/build.make
bin/bench_httpclient: lib/libevent_extra.a
bin/bench_httpclient: CMakeFiles/bench_httpclient.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/linhui/workspace/OCRService/external_src/libevent/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable bin/bench_httpclient"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/bench_httpclient.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/bench_httpclient.dir/build: bin/bench_httpclient

.PHONY : CMakeFiles/bench_httpclient.dir/build

CMakeFiles/bench_httpclient.dir/requires: CMakeFiles/bench_httpclient.dir/test/bench_httpclient.c.o.requires

.PHONY : CMakeFiles/bench_httpclient.dir/requires

CMakeFiles/bench_httpclient.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/bench_httpclient.dir/cmake_clean.cmake
.PHONY : CMakeFiles/bench_httpclient.dir/clean

CMakeFiles/bench_httpclient.dir/depend:
	cd /home/linhui/workspace/OCRService/external_src/libevent/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/linhui/workspace/OCRService/external_src/libevent /home/linhui/workspace/OCRService/external_src/libevent /home/linhui/workspace/OCRService/external_src/libevent/build /home/linhui/workspace/OCRService/external_src/libevent/build /home/linhui/workspace/OCRService/external_src/libevent/build/CMakeFiles/bench_httpclient.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/bench_httpclient.dir/depend

