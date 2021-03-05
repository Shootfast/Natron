include(ExternalProject)

# OpenFX
add_library(OpenFX INTERFACE)
target_include_directories(OpenFX
	INTERFACE
		"${CMAKE_CURRENT_SOURCE_DIR}/OpenFX/include"
		"${CMAKE_CURRENT_SOURCE_DIR}/OpenFX/HostSupport/include"
)
target_compile_definitions(OpenFX
	INTERFACE
		OFX_EXTENSIONS_TUTTLE
		OFX_EXTENSIONS_NATRON
		OFX_EXTENSIONS_NUKE
		OFX_EXTENSIONS_VEGAS
		OFX_SUPPORTS_OPENGLRENDER
)

# OpenFX Extensions
set(OPENFX_EXT_SOURCES
	OpenFX_extensions/ofxhParametricParam.cpp
)
add_library(OpenFX_extensions STATIC ${OPENFX_EXT_SOURCES})
target_link_libraries(OpenFX_extensions
	PUBLIC
		OpenFX
)
target_include_directories(OpenFX_extensions
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}/OpenFX_extensions"
)

# SequenceParsing
add_library(SequenceParsing STATIC SequenceParsing/SequenceParsing.cpp)
target_include_directories(SequenceParsing 
	PUBLIC 
		"${CMAKE_CURRENT_SOURCE_DIR}/SequenceParsing"
)

# Gflags
set(GFLAGS_SOURCES
	gflags/src/gflags.cc
	gflags/src/gflags_completions.cc
	gflags/src/gflags_reporting.cc
)
if(WIN32)
	list(APPEND GFLAGS_SOURCES gflags/src/windows_port.cc)
endif()

add_library(gflags STATIC ${GFLAGS_SOURCES})
target_include_directories(gflags
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}/gflags/src"
	PRIVATE
		"${CMAKE_CURRENT_SOURCE_DIR}/gflags/src/gflags"
)


# Glog
set(GLOG_SOURCES
	glog/src/signalhandler.cc
	glog/src/raw_logging.cc
	glog/src/utilities.cc
	glog/src/demangle.cc
	glog/src/vlog_is_on.cc
	glog/src/logging.cc
	glog/src/symbolize.cc
)	
if(WIN32)
	list(APPEND GLOG_SOURCES glog/src/windows/port.cc)
endif()

add_library(glog STATIC ${GLOG_SOURCES})
target_include_directories(glog
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}/glog/src"
)
target_link_libraries(glog PUBLIC gflags)


# Eigen
add_library(Eigen3 INTERFACE)
target_include_directories(Eigen3
	INTERFACE
		"${CMAKE_CURRENT_SOURCE_DIR}/Eigen3"
)


# Ceres
set(CERES_SOURCES
	ceres/internal/ceres/array_utils.cc
	ceres/internal/ceres/blas.cc
	ceres/internal/ceres/block_evaluate_preparer.cc
	ceres/internal/ceres/block_jacobian_writer.cc
	ceres/internal/ceres/block_jacobi_preconditioner.cc
	ceres/internal/ceres/block_random_access_dense_matrix.cc
	ceres/internal/ceres/block_random_access_diagonal_matrix.cc
	ceres/internal/ceres/block_random_access_matrix.cc
	ceres/internal/ceres/block_random_access_sparse_matrix.cc
	ceres/internal/ceres/block_sparse_matrix.cc
	ceres/internal/ceres/block_structure.cc
	ceres/internal/ceres/callbacks.cc
	ceres/internal/ceres/c_api.cc
	ceres/internal/ceres/cgnr_solver.cc
	ceres/internal/ceres/compressed_col_sparse_matrix_utils.cc
	ceres/internal/ceres/compressed_row_jacobian_writer.cc
	ceres/internal/ceres/compressed_row_sparse_matrix.cc
	ceres/internal/ceres/conditioned_cost_function.cc
	ceres/internal/ceres/conjugate_gradients_solver.cc
	ceres/internal/ceres/coordinate_descent_minimizer.cc
	ceres/internal/ceres/corrector.cc
	ceres/internal/ceres/covariance.cc
	ceres/internal/ceres/covariance_impl.cc
	ceres/internal/ceres/dense_normal_cholesky_solver.cc
	ceres/internal/ceres/dense_qr_solver.cc
	ceres/internal/ceres/dense_sparse_matrix.cc
	ceres/internal/ceres/detect_structure.cc
	ceres/internal/ceres/dogleg_strategy.cc
	ceres/internal/ceres/dynamic_compressed_row_jacobian_writer.cc
	ceres/internal/ceres/dynamic_compressed_row_sparse_matrix.cc
	ceres/internal/ceres/evaluator.cc
	ceres/internal/ceres/file.cc
	ceres/internal/ceres/generated/partitioned_matrix_view_d_d_d.cc
	ceres/internal/ceres/generated/schur_eliminator_d_d_d.cc
	ceres/internal/ceres/gradient_checker.cc
	ceres/internal/ceres/gradient_checking_cost_function.cc
	ceres/internal/ceres/gradient_problem.cc
	ceres/internal/ceres/gradient_problem_solver.cc
	ceres/internal/ceres/implicit_schur_complement.cc
	ceres/internal/ceres/is_close.cc
	ceres/internal/ceres/iterative_schur_complement_solver.cc
	ceres/internal/ceres/lapack.cc
	ceres/internal/ceres/levenberg_marquardt_strategy.cc
	ceres/internal/ceres/linear_least_squares_problems.cc
	ceres/internal/ceres/linear_operator.cc
	ceres/internal/ceres/linear_solver.cc
	ceres/internal/ceres/line_search.cc
	ceres/internal/ceres/line_search_direction.cc
	ceres/internal/ceres/line_search_minimizer.cc
	ceres/internal/ceres/line_search_preprocessor.cc
	ceres/internal/ceres/local_parameterization.cc
	ceres/internal/ceres/loss_function.cc
	ceres/internal/ceres/low_rank_inverse_hessian.cc
	ceres/internal/ceres/minimizer.cc
	ceres/internal/ceres/normal_prior.cc
	ceres/internal/ceres/parameter_block_ordering.cc
	ceres/internal/ceres/partitioned_matrix_view.cc
	ceres/internal/ceres/polynomial.cc
	ceres/internal/ceres/preconditioner.cc
	ceres/internal/ceres/preprocessor.cc
	ceres/internal/ceres/problem.cc
	ceres/internal/ceres/problem_impl.cc
	ceres/internal/ceres/program.cc
	ceres/internal/ceres/reorder_program.cc
	ceres/internal/ceres/residual_block.cc
	ceres/internal/ceres/residual_block_utils.cc
	ceres/internal/ceres/schur_complement_solver.cc
	ceres/internal/ceres/schur_eliminator.cc
	ceres/internal/ceres/schur_jacobi_preconditioner.cc
	ceres/internal/ceres/scratch_evaluate_preparer.cc
	ceres/internal/ceres/solver.cc
	ceres/internal/ceres/solver_utils.cc
	ceres/internal/ceres/sparse_matrix.cc
	ceres/internal/ceres/sparse_normal_cholesky_solver.cc
	ceres/internal/ceres/split.cc
	ceres/internal/ceres/stringprintf.cc
	ceres/internal/ceres/triplet_sparse_matrix.cc
	ceres/internal/ceres/trust_region_minimizer.cc
	ceres/internal/ceres/trust_region_preprocessor.cc
	ceres/internal/ceres/trust_region_step_evaluator.cc
	ceres/internal/ceres/trust_region_strategy.cc
	ceres/internal/ceres/types.cc
	ceres/internal/ceres/wall_time.cc
)
add_library(ceres STATIC ${CERES_SOURCES})
target_include_directories(ceres
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}/ceres/include"
		"${CMAKE_CURRENT_SOURCE_DIR}/ceres/config"
	PRIVATE
		"${CMAKE_CURRENT_SOURCE_DIR}/ceres/internal"
)
target_link_libraries(ceres
	PRIVATE
		glog
		Eigen3
)

target_compile_definitions(ceres
	PUBLIC
		CERES_HAVE_PTHREAD
		CERES_NO_SUITESPARSE
		CERES_NO_CXSPARSE
		CERES_HAVE_RWLOCK
		CERES_NO_LAPACK
		CERES_USE_OPENMP
		CERES_RESTRICT_SCHUR_SPECIALIZATION
		CERES_STD_UNORDERED_MAP
		CERES_STD_SHARED_PTR
)

# openMVG
add_library(openMVG INTERFACE)
target_include_directories(ceres
	INTERFACE
		"${CMAKE_CURRENT_SOURCE_DIR}/openMVG"
)

# hoedown
set(HOEDOWN_SOURCES
	hoedown/src/autolink.c
	hoedown/src/buffer.c
	hoedown/src/document.c
	hoedown/src/escape.c
	hoedown/src/html_blocks.c
	hoedown/src/html.c
	hoedown/src/html_smartypants.c
	hoedown/src/stack.c
	hoedown/src/version.c
)
add_library(hoedown STATIC ${HOEDOWN_SOURCES})
target_include_directories(hoedown
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}/hoedown/src"
)

# libtess
set(LIBTESS_SOURCES
	libtess/dict.c
	libtess/geom.c
	libtess/memalloc.c
	libtess/mesh.c
	libtess/normal.c
	libtess/priorityq.c
	libtess/priorityq-heap.c
	libtess/render.c
	libtess/sweep.c
	libtess/tess.c
	libtess/tessmono.c
)
add_library(libtess STATIC ${LIBTESS_SOURCES})
target_include_directories(libtess
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}/libtess"
)


# libmv
set(LIBMV_SOURCES
	libmv/libmv/autotrack/autotrack.cc
	libmv/libmv/autotrack/predict_tracks.cc
	libmv/libmv/autotrack/tracks.cc
	libmv/libmv/image/array_nd.cc
	libmv/libmv/image/convolve.cc
	libmv/libmv/multiview/conditioning.cc
	libmv/libmv/multiview/homography.cc
	libmv/libmv/multiview/projection.cc
	libmv/libmv/numeric/numeric.cc
	libmv/libmv/tracking/track_region.cc
)	
add_library(libmv STATIC ${LIBMV_SOURCES})
target_include_directories(libmv
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}/libmv"
)
target_link_libraries(libmv
	PUBLIC
		Eigen3
		ceres
		glog
)

# qhttpserver
set(QHTTPSERVER_SOURCES
	qhttpserver/src/qhttpconnection.cpp
	qhttpserver/src/qhttprequest.cpp
	qhttpserver/src/qhttpresponse.cpp
	qhttpserver/src/qhttpserver.cpp	
)
add_library(qhttpserver STATIC ${QHTTPSERVER_SOURCES})
target_include_directories(qhttpserver
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}/qhttpserver/src"
		"${CMAKE_CURRENT_SOURCE_DIR}/qhttpserver/http-parser"
)
target_link_libraries(qhttpserver
	PUBLIC
		Qt5::Core
		Qt5::Network
)


# yaml-cpp
set(YAMLCPP_SOURCES
	yaml-cpp/src/binary.cpp
	yaml-cpp/src/contrib/graphbuilderadapter.cpp
	yaml-cpp/src/contrib/graphbuilder.cpp
	yaml-cpp/src/convert.cpp
	yaml-cpp/src/directives.cpp
	yaml-cpp/src/emit.cpp
	yaml-cpp/src/emitfromevents.cpp
	yaml-cpp/src/emitter.cpp
	yaml-cpp/src/emitterstate.cpp
	yaml-cpp/src/emitterutils.cpp
	yaml-cpp/src/exp.cpp
	yaml-cpp/src/memory.cpp
	yaml-cpp/src/nodebuilder.cpp
	yaml-cpp/src/node.cpp
	yaml-cpp/src/node_data.cpp
	yaml-cpp/src/nodeevents.cpp
	yaml-cpp/src/null.cpp
	yaml-cpp/src/ostream_wrapper.cpp
	yaml-cpp/src/parse.cpp
	yaml-cpp/src/parser.cpp
	yaml-cpp/src/regex_yaml.cpp
	yaml-cpp/src/scanner.cpp
	yaml-cpp/src/scanscalar.cpp
	yaml-cpp/src/scantag.cpp
	yaml-cpp/src/scantoken.cpp
	yaml-cpp/src/simplekey.cpp
	yaml-cpp/src/singledocparser.cpp
	yaml-cpp/src/stream.cpp
	yaml-cpp/src/tag.cpp
)
add_library(yaml-cpp STATIC ${YAMLCPP_SOURCES})
target_include_directories(yaml-cpp
	PUBLIC
		"${CMAKE_CURRENT_SOURCE_DIR}/yaml-cpp/include"
)
target_compile_definitions(yaml-cpp
	PUBLIC
		YAML=YAML_NATRON
)


# exprtk
add_library(exprtk INTERFACE)
target_include_directories(exprtk
	INTERFACE
		"${CMAKE_CURRENT_SOURCE_DIR}/exprtk"
)
