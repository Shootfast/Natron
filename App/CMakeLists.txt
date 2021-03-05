set(SOURCES
	NatronApp_main.cpp
)
add_executable(Natron ${SOURCES})

target_link_libraries(Natron
	PRIVATE
		Natron::Gui
		Qt5::Core
		Python::Python
)
