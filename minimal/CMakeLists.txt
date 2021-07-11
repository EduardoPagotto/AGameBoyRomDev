cmake_minimum_required(VERSION 3.16.3)

PROJECT(hello)

message(STATUS "Toolchain file in: ${CMAKE_TOOLCHAIN_FILE}.")
enable_language(ASM)
#set(CMAKE_C_STANDARD 99)
#set(CMAKE_C_STANDARD_REQUIRED ON)
#set(CMAKE_C_EXTENSIONS OFF)

set(GENERATED_FILES hello.s)
set(EXECUTABLE ${PROJECT_NAME}.elf)

add_executable(${EXECUTABLE} ${GENERATED_FILES})

# target_compile_definitions(${EXECUTABLE} PRIVATE
#         -DUSE_HAL_DRIVER
#         -DSTM32F413xx
#         )

# target_include_directories(${EXECUTABLE} PRIVATE
#         BSP/Inc
#         BSP/Drivers/STM32F4xx_HAL_Driver/Inc
#         BSP/Drivers/CMSIS/Device/ST/STM32F4xx/Include
#         BSP/Drivers/CMSIS/Include)

# target_compile_options(${EXECUTABLE} PRIVATE
#         -mcpu=arm926ej-s
#         #-g
#         -mthumb
#         # #-mfpu=fpv4-sp-d16
#         # #-mfloat-abi=hard
#         #-fdata-sections
#         # -ffunction-sections
#         # -Wall
#         # $<$<CONFIG:Debug>:-Og>
# )

target_link_options(${EXECUTABLE} PRIVATE
        -T${CMAKE_CURRENT_SOURCE_DIR}/memmap.ld
        #-mcpu=arm926ej-s
        # -g
        # -mthumb
        # #-mfpu=fpv4-sp-d16
        # -mfloat-abi=hard
        # -specs=nano.specs
        # -lc
        # -lm
        # -lnosys
        # #-Wl,-Map=${PROJECT_NAME}.map,--cref
        # -Wl,--gc-sections
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
