################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/_write.c \
../src/adc.c \
../src/dma.c \
../src/gpio.c \
../src/iwdg.c \
../src/main.c \
../src/rtc.c \
../src/stm32f0xx_it.c \
../src/usart.c \
../src/wwdg.c 

OBJS += \
./src/_write.o \
./src/adc.o \
./src/dma.o \
./src/gpio.o \
./src/iwdg.o \
./src/main.o \
./src/rtc.o \
./src/stm32f0xx_it.o \
./src/usart.o \
./src/wwdg.o 

C_DEPS += \
./src/_write.d \
./src/adc.d \
./src/dma.d \
./src/gpio.d \
./src/iwdg.d \
./src/main.d \
./src/rtc.d \
./src/stm32f0xx_it.d \
./src/usart.d \
./src/wwdg.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -Wall -Wextra  -g -DOS_USE_TRACE_SEMIHOSTING_DEBUG -I"../include" -I"../system/include" -I"../system/include/cmsis" -I"../system/include/stm32f0xx" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


