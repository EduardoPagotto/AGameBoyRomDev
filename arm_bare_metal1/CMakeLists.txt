cmake_minimum_required(VERSION 3.16.3)

PROJECT(test) 
message(STATUS "Toolchain file in: ${CMAKE_TOOLCHAIN_FILE}.")
enable_language(C ASM)

set(OBJECT_GEN_FLAGS "-fomit-frame-pointer -mcpu=arm926ej-s -g")
set(CMAKE_C_FLAGS   "-marm -std=c99 -O3 -pedantic -Wall -nostartfiles -lm -lc" CACHE INTERNAL "C Compiler options")
set(CMAKE_ASM_FLAGS "${OBJECT_GEN_FLAGS}" CACHE INTERNAL "ASM Compiler options")
#set(CMAKE_EXE_LINKER_FLAGS "-T${CMAKE_CURRENT_SOURCE_DIR}/test.ld" CACHE INTERNAL "Linker options")

set(GENERATED_FILES test.c
                    startup.s 
)

set(EXECUTABLE ${PROJECT_NAME}.out)

add_executable(${EXECUTABLE} ${GENERATED_FILES})

target_link_options(${EXECUTABLE} PRIVATE
        -T${CMAKE_CURRENT_SOURCE_DIR}/test.ld
        -mcpu=arm926ej-s
        # -g
        # -mthumb
        # #-mfpu=fpv4-sp-d16
        # -mfloat-abi=hard
        # -specs=nano.specs
        # -lnosys
        # #-Wl,-Map=${PROJECT_NAME}.map,--cref
        -Wl,--gc-sections
        -Wl,-z,muldefs
)

set(DST_END ${CMAKE_SOURCE_DIR}/bin)

# Print executable size
add_custom_command(TARGET ${EXECUTABLE} 
        POST_BUILD
        COMMAND ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-size ${DST_END}/${EXECUTABLE})

# Create aux files
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-objdump -D ${DST_END}/${EXECUTABLE} > ${DST_END}/${PROJECT_NAME}.list
        COMMAND ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-objcopy -O ihex ${DST_END}/${EXECUTABLE} ${DST_END}/${PROJECT_NAME}.hex
        COMMAND ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-objcopy -O binary ${DST_END}/${EXECUTABLE} ${DST_END}/${PROJECT_NAME}.bin
        COMMAND ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-objdump -d ${DST_END}/${EXECUTABLE} -l > ${DST_END}/${PROJECT_NAME}_dissasembler.s
)