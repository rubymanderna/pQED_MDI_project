# gau2gridConfig.cmake
# --------------------
#
# GAU2GRID cmake module.
# This module sets the following variables in your project::
#
#   gau2grid_FOUND - true if gau2grid and all required components found on the system
#   gau2grid_VERSION - gau2grid version in format Major.Minor.Release
#   gau2grid_INCLUDE_DIRS - Directory where gau2grid header is located.
#   gau2grid_INCLUDE_DIR - same as DIRS
#   gau2grid_LIBRARIES - gau2grid library to link against.
#   gau2grid_LIBRARY - same as LIBRARIES
#
#
# Available components:
#
#   shared - search for only shared library
#   static - search for only static library
#
#
# Exported targets::
#
# If gau2grid is found, this module defines the following :prop_tgt:`IMPORTED`
# target. Target is shared _or_ static, so, for both, use separate, not
# overlapping, installations. ::
#
#   gau2grid::gg - the main gau2grid library with header attached.
#
#
# Suggested usage::
#
#   find_package(gau2grid)
#   find_package(gau2grid 1.0.1 EXACT CONFIG REQUIRED)
#
#
# The following variables can be set to guide the search for this package::
#
#   gau2grid_DIR - CMake variable, set to directory containing this Config file
#   CMAKE_PREFIX_PATH - CMake variable, set to root directory of this package
##   PATH - environment variable, set to bin directory of this package
#   CMAKE_DISABLE_FIND_PACKAGE_gau2grid - CMake variable, disables
#     find_package(gau2grid) when not REQUIRED, perhaps to force internal build


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was gau2gridConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

set(PN gau2grid)

if(OFF)
    set(${PN}_shared_FOUND 1)
else()
    set(${PN}_static_FOUND 1)
endif()

check_required_components(${PN})

#-----------------------------------------------------------------------------
# Don't include targets if this file is being picked up by another
# project which has already built this as a subproject
#-----------------------------------------------------------------------------
if(NOT TARGET ${PN}::gg)
    include("${CMAKE_CURRENT_LIST_DIR}/${PN}Targets.cmake")

    get_property(_loc TARGET ${PN}::gg PROPERTY LOCATION)
    set(${PN}_LIBRARY ${_loc})
    get_property(_ill TARGET ${PN}::gg PROPERTY INTERFACE_LINK_LIBRARIES)
    set(${PN}_LIBRARIES ${_ill})

    get_property(_id TARGET ${PN}::gg PROPERTY INCLUDE_DIRECTORIES)
    set(${PN}_INCLUDE_DIR ${_id})
    get_property(_iid TARGET ${PN}::gg PROPERTY INTERFACE_INCLUDE_DIRECTORIES)
    set(${PN}_INCLUDE_DIRS ${_iid})
endif()

