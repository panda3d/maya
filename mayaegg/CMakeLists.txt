set(MAYAEGG_SOURCES
  config_mayaegg.cxx
  mayaBlendDesc.cxx
  mayaEggGroupUserData.cxx
  mayaEggLoader.cxx
  mayaNodeDesc.cxx
  mayaNodeTree.cxx
  mayaToEggConverter.cxx
)

set(MAYAEGG_HEADERS
  config_mayaegg.h
  mayaBlendDesc.h
  mayaEggGroupUserData.h mayaEggGroupUserData.I
  mayaEggLoader.h
  mayaNodeDesc.h
  mayaNodeTree.h
  mayaToEggConverter.h
)

add_library(mayaegg${MAYA_VERSION} ${MAYAEGG_HEADERS} ${MAYAEGG_SOURCES})
target_include_directories(mayaegg${MAYA_VERSION} INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(mayaegg${MAYA_VERSION} PUBLIC maya${MAYA_VERSION} pandaegg p3converter)
