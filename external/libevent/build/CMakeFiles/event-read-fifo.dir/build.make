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
include CMakeFiles/event-read-fifo.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/event-read-fifo.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/event-read-fifo.dir/flags.make

CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o: CMakeFiles/event-read-fifo.dir/flags.make
CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o: ../sample/event-read-fifo.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/linhui/workspace/OCRService/external_src/libevent/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o   -c /home/linhui/workspace/OCRService/external_src/libevent/sample/event-read-fifo.c

CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/linhui/workspace/OCRService/external_src/libevent/sample/event-read-fifo.c > CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.i

CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/linhui/workspace/OCRService/external_src/libevent/sample/event-read-fifo.c -o CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.s

CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o.requires:

.PHONY : CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o.requires

CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o.provides: CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o.requires
	$(MAKE) -f CMakeFiles/event-read-fifo.dir/build.make CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o.provides.build
.PHONY : CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o.provides

CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o.provides.build: CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o


# Object files for target event-read-fifo
event__read__fifo_OBJECTS = \
"CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o"

# External object files for target event-read-fifo
event__read__fifo_EXTERNAL_OBJECTS =

bin/event-read-fifo: CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o
bin/event-read-fifo: CMakeFiles/event-read-fifo.dir/build.make
bin/event-read-fifo: lib/libevent_extra.a
bin/event-read-fifo: /usr/lib/x86_64-linux-gnu/libssl.so
bin/event-read-fifo: /usr/lib/x86_64-linux-gnu/libcrypto.so
bin/event-read-fifo: /usr/lib/x86_64-linux-gnu/libz.so
bin/event-read-fifo: CMakeFiles/event-read-fifo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/linhui/workspace/OCRService/external_src/libevent/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable bin/event-read-fifo"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/event-read-fifo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/event-read-fifo.dir/build: bin/event-read-fifo

.PHONY : CMakeFiles/event-read-fifo.dir/build

CMakeFiles/event-read-fifo.dir/requires: CMakeFiles/event-read-fifo.dir/sample/event-read-fifo.c.o.requires

.PHONY : CMakeFiles/event-read-fifo.dir/requires

CMakeFiles/event-read-fifo.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/event-read-fifo.dir/cmake_clean.cmake
.PHONY : CMakeFiles/event-read-fifo.dir/clean

CMakeFiles/event-read-fifo.dir/depend:
	cd /home/linhui/workspace/OCRService/external_src/libevent/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/linhui/workspace/OCRService/external_src/libevent /home/linhui/workspace/OCRService/external_src/libevent /home/linhui/workspace/OCRService/external_src/libevent/build /home/linhui/workspace/OCRService/external_src/libevent/build /home/linhui/workspace/OCRService/external_src/libevent/build/CMakeFiles/event-read-fifo.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/event-read-fifo.dir/depend

