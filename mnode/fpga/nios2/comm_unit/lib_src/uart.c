/*------------------------------------------------------------*-
  
  Copyright(c) Minh-An Dao 2022. All Rights Reserved.

---------------------------------------------------------------*/
/**
 * @file      uart.c
 * @brief     
 * @version   $Revision: 1.00 $
 * @date      $Date: 10/3/2022 $
 * @details
 *            - Inherited from Intel Example Source code
 *
 --------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "system.h"
#include <fcntl.h>
#include <unistd.h>
#include "uart.h"
#include <string.h>
#include <altera_avalon_pio_regs.h>

// ------ Directive -------------------------------------------
#define UART_DEBUG

// ------ Private constants -----------------------------------
#define UART0_NAME NIOS_COMM_SYSTEM_RS485_UART_0_NAME
#define UART1_NAME NIOS_COMM_SYSTEM_RS485_UART_1_NAME
// ------ Private variables -----------------------------------
// static
/** @brief median file used for read and write to uart peripheral */
static FILE *uart0_file;
static FILE *uart1_file;
// ------ EXTERNAL variables -------------------------
// extern 
// ------ Private function prototypes -------------------------
// static 
// ------ EXTERNAL function prototypes -------------------------
// extern 
//--------------------------------------------------------------
// FUNCTION DEFINITIONS
//--------------------------------------------------------------
/**
 * @brief
 */
static void set_blocking(FILE *uart_file, bool blocking)
{
    if (blocking == false) {
        fcntl(fileno(uart_file), F_SETFL, O_NONBLOCK);
    } else {
        int file_fl = fcntl(fileno(uart_file), F_GETFL);
        file_fl = file_fl & ~O_NONBLOCK;
        fcntl(fileno(uart_file), F_SETFL, file_fl);
    }
}

/**
 * @brief
 */
// static void dump_rx(FILE *uart_file)
// {
//     char buffer[1000];
//     set_blocking(uart_file, false);
//     while (uart_gets(buffer, sizeof(buffer)) != NULL) {
// #ifdef UART_DEBUG
//         printf("%s", buffer);
// #endif
//     }
//     set_blocking(uart_file, true);
//     fflush(stdout);
// }

/**
 * @brief
 */
// bool uarts_init(bool reset)
// {
    // bool bSuccess = true;
bool uarts_init(void)
{ 
    // --- UART 0 initialize
    uart0_file = fopen(UART0_NAME, "rw+");
    if (uart0_file == NULL) {
        printf("Open UART_0 failed\n");
        return false;
    }
    // --- UART 1 initialize
    uart1_file = fopen(UART1_NAME, "rw+");
    if (uart1_file == NULL) {
        printf("Open UART_1 failed\n");
        return false;
    }

    printf("UARTs initialization done.\n");
    return true;
    // if (reset) {
    //     IOWR_ALTERA_AVALON_PIO_DATA(NIOS_COMM_SYSTEM_PIO_WIFI_RESET_BASE, 0);
    //     usleep(50);
    //     IOWR_ALTERA_AVALON_PIO_DATA(NIOS_COMM_SYSTEM_PIO_WIFI_RESET_BASE, 1);
    //     usleep(3 * 1000 * 1000);
    //     dump_rx(uart0_file);
    // }
    // char ssid[20], passwd[20];
    // uart_send_command("AT+CWMODE_CUR=1");
    // uart_send_command("AT+CWLAPOPT=1,0x2");
    // printf("Network Name (SSID) List:\n");
    // uart_send_command("AT+CWLAP");
    // printf("Enter the Network Name (SSID): ");
    // scanf("%s", ssid);
    // printf("\n");
    // printf("Enter the Password of Network Name (SSID): ");
    // scanf("%s", passwd);
    // printf("\n");

    // printf("Connecting to WiFi AP (SSID: %s)\n", ssid);
    // char cmd[100];
    // sprintf(cmd, "AT+CWJAP_CUR=\"%s\",\"%s\"", ssid, passwd);
    // bSuccess = uart_send_command(cmd);
    // if (bSuccess) {
    //     printf("Connect to WiFi AP successfully\n");
    // } else {
    //     printf("Connect to WiFi AP failed\n");
    // }

    // return bSuccess;
}

/**
 * @brief
 */
bool uart0_send_command(const char *cmd)
{
    fprintf(uart0_file, "%s\r\n", cmd);
    return true;
//     int length = 0;
//     char buffer[1000];
//     while (1) {
//         if (fgets(buffer + length, sizeof(buffer) - length, uart0_file) != NULL) {
// #ifdef UART_DEBUG
//             printf("%s", buffer + length);
// #endif
//             if (strstr(buffer + length, "OK") != NULL) {
//                 if (strcmp("AT+CWLAP", cmd) == 0) {
//                     printf("%s", buffer);
//                 }
//                 return true;
//             } else if (strstr(buffer + length, "ERROR") != NULL) {
//                 return false;
//             } else if (strstr(buffer + length, "FAIL") != NULL) {
//                 return false;
//             }
//             length += strlen(buffer + length);
//         }
//     }
//     return false;
}
bool uart1_send_command(const char *cmd)
{
    fprintf(uart1_file, "%s\r\n", cmd);
    return true;
}
/**
 * @brief
 */
bool uart0_send_data(const char *data, int length)
{
    write(fileno(uart0_file), data, length);
    return true;
//     length = 0;
//     char buffer[1000];
//     while (1) {
//         if (fgets(buffer + length, sizeof(buffer) - length,
//                 uart0_file) != NULL) {
// #ifdef UART_DEBUG
//             printf("%s", buffer + length);
// #endif
//             if (strstr(buffer + length, "SEND OK") != NULL) {
//                 return true;
//             } else if (strstr(buffer + length, "SEND FAIL") != NULL) {
//                 printf("%s", buffer);
//                 return false;
//             }
//             length += strlen(buffer + length);
//         }
//     }
//     return false;
}

bool uart1_send_data(const char *data, int length)
{
    write(fileno(uart1_file), data, length);
    return true;
}

/**
 * @brief
 */
char *uart0_gets(char *buffer, int buffer_size)
{
    return fgets(buffer, buffer_size, uart0_file);
}

char *uart1_gets(char *buffer, int buffer_size)
{
    return fgets(buffer, buffer_size, uart1_file);
}