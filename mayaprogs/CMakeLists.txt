add_library(mayaeggimport${MAYA_VERSION} MODULE mayaEggImport.cxx)
target_link_libraries(mayaeggimport${MAYA_VERSION} mayaegg${MAYA_VERSION})
maya_set_plugin_properties(mayaeggimport${MAYA_VERSION})

add_library(p3mayaloader${MAYA_VERSION} MODULE config_mayaloader.cxx)
target_link_libraries(p3mayaloader${MAYA_VERSION} mayaegg${MAYA_VERSION})

add_library(mayapview${MAYA_VERSION} MODULE mayaPview.cxx)
target_link_libraries(mayapview${MAYA_VERSION} mayaegg${MAYA_VERSION} p3framework)
maya_set_plugin_properties(mayaeggimport${MAYA_VERSION})

add_executable(maya2egg${MAYA_VERSION}_bin mayaToEggBin.cxx mayaToEgg.cxx eggToMaya.cxx mayaConversionServer.cxx)
target_link_libraries(maya2egg${MAYA_VERSION}_bin mayaegg${MAYA_VERSION} p3eggbase p3progbase)

add_executable(egg2maya${MAYA_VERSION}_bin eggToMayaBin.cxx mayaToEgg.cxx eggToMaya.cxx mayaConversionServer.cxx)
target_link_libraries(egg2maya${MAYA_VERSION}_bin mayaegg${MAYA_VERSION} p3eggbase p3progbase)

add_library(mayasavepview${MAYA_VERSION} MODULE mayasavepview.cxx)
target_link_libraries(mayasavepview${MAYA_VERSION} mayaegg${MAYA_VERSION})
maya_set_plugin_properties(mayasavepview${MAYA_VERSION})

add_executable(maya2egg${MAYA_VERSION} mayapath.cxx)
target_link_libraries(maya2egg${MAYA_VERSION} mayaegg${MAYA_VERSION})

add_executable(egg2maya${MAYA_VERSION} mayapath.cxx)
target_link_libraries(egg2maya${MAYA_VERSION} mayaegg${MAYA_VERSION})

add_executable(maya2egg_client mayaConversionClient.cxx mayaToEggClient.cxx)
target_link_libraries(maya2egg_client pandaegg panda)

add_executable(egg2maya_client mayaConversionClient.cxx eggToMayaClient.cxx)
target_link_libraries(egg2maya_client pandaegg panda)
