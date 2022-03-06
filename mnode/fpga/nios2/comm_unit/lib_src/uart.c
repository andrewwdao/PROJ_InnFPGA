/*
 * uart.c
 *
 *  Created on: 2016/10/7
 *      Author: User
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "system.h"
#include <fcntl.h>
#include <unistd.h>
#include "uart.h"
#include <string.h>
#include <altera_avalon_pio_regs.h>

#define uart_name NIOS_COMM_SYSTEM_RS485_UART_0_NAME
#define UART_DEBUG

FILE *uart_file;

void set_uart_file_blocking(bool blocking)
{
    if (blocking == false) {
        fcntl(fileno(uart_file), F_SETFL, O_NONBLOCK);
    } else {
        int file_fl = fcntl(fileno(uart_file), F_GETFL);
        file_fl = file_fl & ~O_NONBLOCK;
        fcntl(fileno(uart_file), F_SETFL, file_fl);
    }
}

bool uart_init(bool reset)
{
    bool bSuccess = true;
    uart_file = fopen(uart_name, "rw+");
    if (uart_file == NULL) {
        printf("Open UART_0 failed\n");
        return false;
    }
    if (reset) {
        IOWR_ALTERA_AVALON_PIO_DATA(NIOS_COMM_SYSTEM_PIO_WIFI_RESET_BASE, 0);
        usleep(50);
        IOWR_ALTERA_AVALON_PIO_DATA(NIOS_COMM_SYSTEM_PIO_WIFI_RESET_BASE, 1);
        usleep(3 * 1000 * 1000);
        uart_dump_rx();
    }
    char ssid[20], passwd[20];
    uart_send_command("AT+CWMODE_CUR=1");
    uart_send_command("AT+CWLAPOPT=1,0x2");
    printf("Network Name (SSID) List:\n");
    uart_send_command("AT+CWLAP");
    printf("Enter the Network Name (SSID): ");
    scanf("%s", ssid);
    printf("\n");
    printf("Enter the Password of Network Name (SSID): ");
    scanf("%s", passwd);
    printf("\n");

    printf("Connecting to WiFi AP (SSID: %s)\n", ssid);
    char cmd[100];
    sprintf(cmd, "AT+CWJAP_CUR=\"%s\",\"%s\"", ssid, passwd);
    bSuccess = uart_send_command(cmd);
    if (bSuccess) {
        printf("Connect to WiFi AP successfully\n");
    } else {
        printf("Connect to WiFi AP failed\n");
    }

    return bSuccess;
}

char *uart_gets(char *buffer, int buffer_size)
{
    return fgets(buffer, buffer_size, uart_file);
}

bool uart_send_command(const char *cmd)
{
    fprintf(uart_file, "%s\r\n", cmd);
    int length = 0;
    char buffer[1000];
    while (1) {
        if (fgets(buffer + length, sizeof(buffer) - length, uart_file) != NULL) {
#ifdef UART_DEBUG
            printf("%s", buffer + length);
#endif
            if (strstr(buffer + length, "OK") != NULL) {
                if (strcmp("AT+CWLAP", cmd) == 0) {
                    printf("%s", buffer);
                }
                return true;
            } else if (strstr(buffer + length, "ERROR") != NULL) {
                return false;
            } else if (strstr(buffer + length, "FAIL") != NULL) {
                return false;
            }
            length += strlen(buffer + length);
        }
    }
    return false;
}

bool uart_send_data(const char *data, int length)
{
    write(fileno(uart_file), data, length);

    length = 0;
    char buffer[1000];
    while (1) {
        if (fgets(buffer + length, sizeof(buffer) - length,
                uart_file) != NULL) {
#ifdef UART_DEBUG
            printf("%s", buffer + length);
#endif
            if (strstr(buffer + length, "SEND OK") != NULL) {
                return true;
            } else if (strstr(buffer + length, "SEND FAIL") != NULL) {
                printf("%s", buffer);
                return false;
            }
            length += strlen(buffer + length);
        }
    }
    return false;
}

void uart_dump_rx()
{
    char buffer[1000];
    set_uart_file_blocking(false);
    while (uart_gets(buffer, sizeof(buffer)) != NULL) {
#ifdef UART_DEBUG
        printf("%s", buffer);
#endif
    }
    set_uart_file_blocking(true);
    fflush(stdout);
}
