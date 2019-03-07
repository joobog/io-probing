#add_definitions("-DGIT_COMMIT_HASH=${GIT_COMMIT_HASH}")
#add_definitions("-DGIT_BRANCH=${GIT_BRANCH}")

add_executable( io-probing ${MDWB_C_SOURCE_DIR}/option.c ${MDWB_C_SOURCE_DIR}/memory.c ${MDWB_C_SOURCE_DIR}/md_util.c main.c ${PLUGINS})

message("MPI_LIBRAIES ${MPI_LIBRARIES}")
message("MPI_INCLUDE_PATH ${MPI_INCLUDE_PATH}")
target_link_libraries(io-probing PRIVATE ${MPI_LIBRARIES} -lm -lpthread)

#set_target_properties(io-probing PROPERTIES INSTALL_RPATH  ${MPI_LIBDIR})
#set_target_properties(io-probing PROPERTIES LINK_FLAGS "${MPI_LINK_FLAGS}")
#set_target_properties(io-probing PROPERTIES COMPILE_FLAGS "${MPI_COMPILE_FLAGS}")
target_include_directories(io-probing SYSTEM PRIVATE ${MPI_INCLUDE_PATH})

#install(TARGETS io-probing RUNTIME DESTINATION bin)

#add_test( NAME dummyRun COMMAND mpiexec -n 2 $ENV{MPI_ARGS} ./io-probing -i=dummy )
#add_test( NAME listModules COMMAND mpiexec -n 2 $ENV{MPI_ARGS} ./io-probing -i=list )


