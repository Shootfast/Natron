set(SOURCES
	FStreamsSupport.cpp
	ProcInfo.cpp
	PythonUtils.cpp
	StrUtils.cpp
	glad_source.c
)
add_library(Global STATIC ${SOURCES})
add_library(Natron::Global ALIAS Global)

target_link_libraries(Global
	PUBLIC
		OpenFX
		Qt5::Core
		OpenGL::GL

	PRIVATE
		Python::Python
)

target_include_directories(Global
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}"
		"${CMAKE_CURRENT_SOURCE_DIR}/.."
		"${CMAKE_CURRENT_SOURCE_DIR}/gladRel/include"
)
