# The original *cmake.in file is part of STIR.
#
# Author: Kris Thielemans
# Author Richard Brown
# Copyright 2016, 2019, 2020, 2022, 2023 University College London
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0.txt
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# This file sets STIR_INCLUDE_DIRS, STIR_LIBRARIES and STIR_REGISTRIES.
# It also finds the packages that were used to build STIR as you need those
# to link against etc. It should normally not be required that you know about
# these, as they should be automatically added to the dependencies of the STIR
# libraries. Therefore, if you make a target that depends on ${STIR_LIBRARIES},
# its include_directories and linkage should automagically be ok.
#
# Usage is like this
#
#  find_package(STIR 5.1 CONFIG)
#  add_executable(my_exe ${STIR_REGISTRIES})
#  target_link_libraries(my_exe ${STIR_LIBRARIES})
#
# In addition, if your CMake (or the version used to compile STIR) is older than 3.12,
# you need to add
#
#  include_directories("${STIR_INCLUDE_DIRS}")
#
# to your CMake file to get the source files listed in STIR_REGISTRIES to compile.
# For more recent CMake, this should not be necessary (as STIR_REGISTRIES is then set to
# a list of compiled files).

# This file also sets variables such as STIR_BUILT_WITH_ITK, STIR_BUILT_WITH_OpenMP etc
# in case you need to how it was built.

####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was STIRConfig.cmake.in                            ########

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

# add folder where this file resides to the cmake path such that it can use our find_package modules and .cmake files
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR};${CMAKE_MODULE_PATH}")

include("${CMAKE_CURRENT_LIST_DIR}/STIRTargets.cmake")

set_and_check(STIR_INCLUDE_DIRS "${PACKAGE_PREFIX_DIR}/include/STIR-6.2")
# cannot use set_and_check on lists at present
# https://gitlab.kitware.com/cmake/cmake/issues/16219
#set(STIR_LIBRARY_DIRS "")
set(STIR_LIBRARIES IO;analytic_FBP3DRP;analytic_FBP2D;analytic_SRT2D;analytic_SRT2DSPECT;iterative_OSMAPOSL;iterative_KOSMAPOSL;iterative_OSSPS;scatter_buildblock;modelling_buildblock;listmode_buildblock;recon_buildblock;display;data_buildblock;numerics_buildblock;buildblock;spatial_transformation_buildblock;Shape_buildblock;eval_buildblock)

# Set STIR_REGISTRIES to either a list of source or object files,
# depending on the CMake version with which STIR was compiled as well as
# the CMake version that is used to import STIR.
if (3.31.6 VERSION_LESS 3.12 OR CMAKE_VERSION VERSION_LESS 3.12)
   set(STIR_REGISTRIES ${PACKAGE_PREFIX_DIR}/share/STIR-6.2/src/IO_registries.cxx;${PACKAGE_PREFIX_DIR}/share/STIR-6.2/src/buildblock_registries.cxx;${PACKAGE_PREFIX_DIR}/share/STIR-6.2/src/recon_buildblock_registries.cxx;${PACKAGE_PREFIX_DIR}/share/STIR-6.2/src/data_buildblock_registries.cxx;${PACKAGE_PREFIX_DIR}/share/STIR-6.2/src/Shape_buildblock_registries.cxx;${PACKAGE_PREFIX_DIR}/share/STIR-6.2/src/modelling_registries.cxx;${PACKAGE_PREFIX_DIR}/share/STIR-6.2/src/spatial_transformation_registries.cxx;${PACKAGE_PREFIX_DIR}/share/STIR-6.2/src/scatter_registries.cxx)
else()
  set(STIR_REGISTRIES $<TARGET_OBJECTS:stir_registries>)
endif()

## find external packages
# Note that we generally need find_package even for those that are only
# PRIVATE dependencies (such as ITK, parallelproj etc). This is because
# otherwise their targets (such as parallelproj::parallelproj_c) don't exist,
# and the user will get CMake errors.
# See https://github.com/UCL/STIR/issues/1535

# we use a trick by Matt McCormick (kitware)
# to set ITK_DIR etc first before calling find_package
# to make sure we pick the same version of the external library

if (STIR_FIND_QUIETLY)
  SET(STIR_FIND_TYPE "QUIET")
else()
  SET(STIR_FIND_TYPE "REQUIRED")
endif()

find_package(Boost 1.84.0 REQUIRED)

if (1)
  message(STATUS "ITK support in STIR enabled.")
  set(ITK_DIR "/root/miniforge3/envs/cilsirfbuild/lib/cmake/ITK-5.4")
  find_package(ITK ${STIR_FIND_TYPE} CONFIG)
  if(NOT ITK_FOUND)
    SET(STIR_FOUND OFF)
  endif()
  set(STIR_BUILT_WITH_ITK TRUE)
endif()

if (TRUE)
  message(STATUS "HDF5 support in STIR enabled.")
  if (CMAKE_VERSION VERSION_LESS 3.21.0)
    # should really look for CXX only, as that's all we need. However, this can create conflicts
    # with older CMake, see https://gitlab.kitware.com/cmake/cmake/-/issues/20909
    # We try to work-around this by first looking for both C and CXX, and then only for CXX.
    # Note that this only solves the problem if in the "client" code,
    # find_package(STIR) is called BEFORE find_package(HDF5)
    find_package(HDF5 1.14 QUIET COMPONENTS C CXX)
  endif()
  find_package(HDF5 1.14 REQUIRED COMPONENTS CXX )

  set(STIR_BUILT_WITH_HDF5 TRUE)
endif()

if (FALSE)
  set(HAVE_ECAT ON)
  message(STATUS "ECAT support in STIR enabled.")
  set(STIR_BUILT_WITH_LLN_MATRIX TRUE)
endif()

if (FALSE)
  set(CERN_ROOT_CONFIG CERN_ROOT_CONFIG-NOTFOUND)
  find_package(CERN_ROOT  REQUIRED ${STIR_FIND_TYPE})
  message(STATUS "CERN ROOT support in STIR enabled.")
  set(STIR_BUILT_WITH_CERN_ROOT TRUE)
endif()

# Following lines are currently not necessary but would need to be enabled
# if nlohmann_json stops being a header-only library.
# See buildblock/CMakeLists.xt
#
#if (1)
#  find_package(nlohmann_json 3.2.0 ${STIR_FIND_TYPE})
#  set(STIR_BUILD_WITH_nlohmann_json TRUE)
#endif()

if (OFF)
  find_package(MPI ${STIR_FIND_TYPE})
  if(NOT MPI_FOUND)
    SET(STIR_FOUND OFF)
  endif()
  set(STIR_BUILT_WITH_MPI TRUE)
endif()

if(ON)
  find_package(OpenMP ${STIR_FIND_TYPE})
  set(STIR_BUILT_WITH_OpenMP TRUE)
endif()

if()
  find_package(CUDAToolkit REQUIRED)
  find_package(NiftyPET REQUIRED)
  set(STIR_WITH_NiftyPET_PROJECTOR TRUE)
endif()

if(ON)
  find_package(CUDAToolkit REQUIRED)
  enable_language(CUDA)
  set(STIR_WITH_CUDA TRUE)
endif()

if(ON)
  find_package(parallelproj REQUIRED CONFIG)
  set(STIR_WITH_Parallelproj_PROJECTOR TRUE)
endif()

SET(STIR_WITH_EXPERIMENTAL OFF)
if(STIR_WITH_EXPERIMENTAL)
    if(${CMAKE_VERSION} VERSION_LESS "3.12.0")
      add_definitions(-DSTIR_WITH_EXPERIMENTAL)
    else()
      add_compile_definitions(STIR_WITH_EXPERIMENTAL)
    endif()
else()
  remove_definitions(-DSTIR_WITH_EXPERIMENTAL)
endif()

# This version of STIR comes with TOF capabilities
set(STIR_TOF 1)
