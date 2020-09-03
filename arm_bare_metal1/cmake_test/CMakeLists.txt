cmake_minimum_required(VERSION 3.16.3)

PROJECT(proj_teste1) 
message(STATUS "Toolchain file in: ${CMAKE_TOOLCHAIN_FILE}.")
enable_language(C ASM)
#set(CMAKE_C_STANDARD 99)
#set(CMAKE_C_STANDARD_REQUIRED ON)
#set(CMAKE_C_EXTENSIONS OFF)

set(GENERATED_FILES test.c
                    startup.s)

set(EXECUTABLE ${PROJECT_NAME}.out)

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

target_compile_options(${EXECUTABLE} PRIVATE
        -mcpu=arm926ej-s
        -g
        #-mthumb
        #-mfpu=fpv4-sp-d16
        #-mfloat-abi=hard
        -fdata-sections
        -ffunction-sections
        -Wall
        $<$<CONFIG:Debug>:-Og>
)

target_link_options(${EXECUTABLE} PRIVATE
        -T${CMAKE_SOURCE_DIR}/test.ld
        -mcpu=arm926ej-s
        -g
        #-mthumb
        #-mfpu=fpv4-sp-d16
        -mfloat-abi=hard
        -specs=nano.specs
        -lc
        -lm
        -lnosys
        -Wl,-Map=${PROJECT_NAME}.map,--cref
        -Wl,--gc-sections
)

# Print executable size
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND arm-none-eabi-size ${EXECUTABLE})

# Create hex file
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND arm-none-eabi-objcopy -O ihex ${EXECUTABLE} ${PROJECT_NAME}.hex
        COMMAND arm-none-eabi-objcopy -O binary ${EXECUTABLE} ${PROJECT_NAME}.bin
)

# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)