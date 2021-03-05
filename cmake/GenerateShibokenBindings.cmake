
find_package(Shiboken2 REQUIRED)
find_package(PySide2 REQUIRED)
macro(generate_shiboken_bindings GENERATED_SOURCE INCLUDE_DIRS HEADER TYPESYSTEM)
	# Find the folder for the generated_sources
	get_filename_component(OUT_DIR ${GENERATED_SOURCE} DIRECTORY)
	get_filename_component(OUT_DIR ${OUT_DIR} DIRECTORY) # need to go up 2 levels
	# Transform the CMake list INCLUDE_DIRS into a colon separated list for shiboken
	string(REPLACE ";" ":" SBK_INCLUDES "${INCLUDE_DIRS}")
	add_custom_command(
		OUTPUT "${GENERATED_SOURCE}"
		COMMAND echo shiboken2 --enable-pyside-extensions --typesystem-paths="${PYSIDE_TYPESYSTEMS}" --include-paths="${SBK_INCLUDES}" "${HEADER}" "${TYPESYSTEM}" --output-directory="${OUT_DIR}"
		COMMAND Shiboken2::shiboken2 --enable-pyside-extensions --typesystem-paths="${PYSIDE_TYPESYSTEMS}" --include-paths="${SBK_INCLUDES}" "${HEADER}" "${TYPESYSTEM}" --output-directory="${OUT_DIR}"
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
		COMMENT "Running generator for ${GENERATED_SOURCE}" 
	)
endmacro()
