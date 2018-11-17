# Install script for directory: /home/linhui/workspace/OCRService/external_src/libevent

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/linhui/workspace/OCRService/external")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "lib" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/linhui/workspace/OCRService/external/lib/libevent.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/lib" TYPE STATIC_LIBRARY FILES "/home/linhui/workspace/OCRService/external_src/libevent/build/lib/libevent.a")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/linhui/workspace/OCRService/external/include/event2/buffer.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent_compat.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent_struct.h;/home/linhui/workspace/OCRService/external/include/event2/buffer_compat.h;/home/linhui/workspace/OCRService/external/include/event2/dns.h;/home/linhui/workspace/OCRService/external/include/event2/dns_compat.h;/home/linhui/workspace/OCRService/external/include/event2/dns_struct.h;/home/linhui/workspace/OCRService/external/include/event2/event.h;/home/linhui/workspace/OCRService/external/include/event2/event_compat.h;/home/linhui/workspace/OCRService/external/include/event2/event_struct.h;/home/linhui/workspace/OCRService/external/include/event2/http.h;/home/linhui/workspace/OCRService/external/include/event2/http_compat.h;/home/linhui/workspace/OCRService/external/include/event2/http_struct.h;/home/linhui/workspace/OCRService/external/include/event2/keyvalq_struct.h;/home/linhui/workspace/OCRService/external/include/event2/listener.h;/home/linhui/workspace/OCRService/external/include/event2/rpc.h;/home/linhui/workspace/OCRService/external/include/event2/rpc_compat.h;/home/linhui/workspace/OCRService/external/include/event2/rpc_struct.h;/home/linhui/workspace/OCRService/external/include/event2/tag.h;/home/linhui/workspace/OCRService/external/include/event2/tag_compat.h;/home/linhui/workspace/OCRService/external/include/event2/thread.h;/home/linhui/workspace/OCRService/external/include/event2/util.h;/home/linhui/workspace/OCRService/external/include/event2/visibility.h;/home/linhui/workspace/OCRService/external/include/event2/event-config.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent_ssl.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/include/event2" TYPE FILE FILES
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/buffer.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/buffer_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/dns.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/dns_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/dns_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/event.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/event_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/event_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/http.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/http_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/http_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/keyvalq_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/listener.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/rpc.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/rpc_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/rpc_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/tag.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/tag_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/thread.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/util.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/visibility.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/build/include/event2/event-config.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent_ssl.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "lib" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/linhui/workspace/OCRService/external/lib/libevent_core.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/lib" TYPE STATIC_LIBRARY FILES "/home/linhui/workspace/OCRService/external_src/libevent/build/lib/libevent_core.a")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/linhui/workspace/OCRService/external/include/event2/buffer.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent_compat.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent_struct.h;/home/linhui/workspace/OCRService/external/include/event2/buffer_compat.h;/home/linhui/workspace/OCRService/external/include/event2/dns.h;/home/linhui/workspace/OCRService/external/include/event2/dns_compat.h;/home/linhui/workspace/OCRService/external/include/event2/dns_struct.h;/home/linhui/workspace/OCRService/external/include/event2/event.h;/home/linhui/workspace/OCRService/external/include/event2/event_compat.h;/home/linhui/workspace/OCRService/external/include/event2/event_struct.h;/home/linhui/workspace/OCRService/external/include/event2/http.h;/home/linhui/workspace/OCRService/external/include/event2/http_compat.h;/home/linhui/workspace/OCRService/external/include/event2/http_struct.h;/home/linhui/workspace/OCRService/external/include/event2/keyvalq_struct.h;/home/linhui/workspace/OCRService/external/include/event2/listener.h;/home/linhui/workspace/OCRService/external/include/event2/rpc.h;/home/linhui/workspace/OCRService/external/include/event2/rpc_compat.h;/home/linhui/workspace/OCRService/external/include/event2/rpc_struct.h;/home/linhui/workspace/OCRService/external/include/event2/tag.h;/home/linhui/workspace/OCRService/external/include/event2/tag_compat.h;/home/linhui/workspace/OCRService/external/include/event2/thread.h;/home/linhui/workspace/OCRService/external/include/event2/util.h;/home/linhui/workspace/OCRService/external/include/event2/visibility.h;/home/linhui/workspace/OCRService/external/include/event2/event-config.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent_ssl.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/include/event2" TYPE FILE FILES
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/buffer.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/buffer_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/dns.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/dns_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/dns_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/event.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/event_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/event_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/http.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/http_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/http_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/keyvalq_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/listener.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/rpc.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/rpc_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/rpc_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/tag.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/tag_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/thread.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/util.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/visibility.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/build/include/event2/event-config.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent_ssl.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "lib" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/linhui/workspace/OCRService/external/lib/libevent_extra.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/lib" TYPE STATIC_LIBRARY FILES "/home/linhui/workspace/OCRService/external_src/libevent/build/lib/libevent_extra.a")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/linhui/workspace/OCRService/external/include/event2/buffer.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent_compat.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent_struct.h;/home/linhui/workspace/OCRService/external/include/event2/buffer_compat.h;/home/linhui/workspace/OCRService/external/include/event2/dns.h;/home/linhui/workspace/OCRService/external/include/event2/dns_compat.h;/home/linhui/workspace/OCRService/external/include/event2/dns_struct.h;/home/linhui/workspace/OCRService/external/include/event2/event.h;/home/linhui/workspace/OCRService/external/include/event2/event_compat.h;/home/linhui/workspace/OCRService/external/include/event2/event_struct.h;/home/linhui/workspace/OCRService/external/include/event2/http.h;/home/linhui/workspace/OCRService/external/include/event2/http_compat.h;/home/linhui/workspace/OCRService/external/include/event2/http_struct.h;/home/linhui/workspace/OCRService/external/include/event2/keyvalq_struct.h;/home/linhui/workspace/OCRService/external/include/event2/listener.h;/home/linhui/workspace/OCRService/external/include/event2/rpc.h;/home/linhui/workspace/OCRService/external/include/event2/rpc_compat.h;/home/linhui/workspace/OCRService/external/include/event2/rpc_struct.h;/home/linhui/workspace/OCRService/external/include/event2/tag.h;/home/linhui/workspace/OCRService/external/include/event2/tag_compat.h;/home/linhui/workspace/OCRService/external/include/event2/thread.h;/home/linhui/workspace/OCRService/external/include/event2/util.h;/home/linhui/workspace/OCRService/external/include/event2/visibility.h;/home/linhui/workspace/OCRService/external/include/event2/event-config.h;/home/linhui/workspace/OCRService/external/include/event2/bufferevent_ssl.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/include/event2" TYPE FILE FILES
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/buffer.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/buffer_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/dns.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/dns_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/dns_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/event.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/event_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/event_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/http.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/http_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/http_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/keyvalq_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/listener.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/rpc.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/rpc_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/rpc_struct.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/tag.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/tag_compat.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/thread.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/util.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/visibility.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/build/include/event2/event-config.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event2/bufferevent_ssl.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/linhui/workspace/OCRService/external/include/evdns.h;/home/linhui/workspace/OCRService/external/include/evrpc.h;/home/linhui/workspace/OCRService/external/include/event.h;/home/linhui/workspace/OCRService/external/include/evhttp.h;/home/linhui/workspace/OCRService/external/include/evutil.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/include" TYPE FILE FILES
    "/home/linhui/workspace/OCRService/external_src/libevent/include/evdns.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/evrpc.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/event.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/evhttp.h"
    "/home/linhui/workspace/OCRService/external_src/libevent/include/evutil.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventConfig.cmake;/home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventConfigVersion.cmake")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/lib/cmake/libevent" TYPE FILE FILES
    "/home/linhui/workspace/OCRService/external_src/libevent/build//CMakeFiles/LibeventConfig.cmake"
    "/home/linhui/workspace/OCRService/external_src/libevent/build/LibeventConfigVersion.cmake"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "dev" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}/home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventTargets.cmake"
         "/home/linhui/workspace/OCRService/external_src/libevent/build/CMakeFiles/Export/_home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}/home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}/home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventTargets.cmake")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/lib/cmake/libevent" TYPE FILE FILES "/home/linhui/workspace/OCRService/external_src/libevent/build/CMakeFiles/Export/_home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "/home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventTargets-release.cmake")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
        message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
        message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
file(INSTALL DESTINATION "/home/linhui/workspace/OCRService/external/lib/cmake/libevent" TYPE FILE FILES "/home/linhui/workspace/OCRService/external_src/libevent/build/CMakeFiles/Export/_home/linhui/workspace/OCRService/external/lib/cmake/libevent/LibeventTargets-release.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/linhui/workspace/OCRService/external_src/libevent/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
