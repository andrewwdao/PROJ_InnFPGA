/*------------------------------------------------------------*-
  
  Copyright(c) Minh-An Dao 2022. All Rights Reserved.

---------------------------------------------------------------*/
/**
 * @file      uart.c
 * @brief     
 * @version   $Revision: 1.00 $
 * @date      $Date: 23/3/2022 $
 * @details
 *            - Inherited from Intel Example Source code
 *
 --------------------------------------------------------------*/
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "system.h"
#include "uart.h"
#include "cJSON.h"

// #define TEST_CMD "something good"
const char *TEST_CMD =
        "START_MSG\
        something good\
        END_MSG\
        ";
// char *get_time(char *str);
void test_connection(void);

int main()
{
    printf("Hello from Nios II!\n");
    while (uarts_init() == false) {
        printf("Init failed. Trying again...");
        usleep(3 * 1000 * 1000);
    }
    // char str[100];
    // int time;
    // int hour, minute, second;
    // while (1) {
    //     if (get_time(str) != NULL) {
    //         if (sscanf(str, "%d:%d:%d", &hour, &minute, &second) == 3) {
    //             time = hour * 10000 + minute * 100 + second;
    //             // SEG7_Decimal(time, 0);
    //         }
    //     }
    // }


    test_connection();
    return 0;
}


void test_connection(void)
{
    char buffer[1000];
    char data[1000];
    char *start,*end;
    // ------------------ UART0 send - UART1 get -----------------
    printf("UART0 send - UART1 get\r\n");
    memset(buffer,0,sizeof(buffer)); // reset all buffer to 0
    memset(data,0,sizeof(data)); // reset all buffer to 0
    if (uart0_send_command(TEST_CMD)) {
        while (1) {
            uart1_gets(buffer, sizeof(buffer));
            start = strstr(buffer, "START_MSG");
            end = strstr(buffer,"END_MSG");
            if (start!=NULL && end!=NULL) {
                *end = '\0'; // stop the string after the end signal
                strcpy(data,start); // extract the data from the package
                printf("data:\r\n%s\r\n", data);
                printf("Test Successful.\r\n");
                break;
            } else {

                printf("Test failed. Trying again...\r\n");
                printf("Full buffer:\r\n%s\r\n", buffer);
                usleep(1 * 500 * 1000);
            }
        }
    }

    // ------------------ UART1 send - UART0 get -----------------
    printf("UART1 send - UART0 get\r\n");
    memset(buffer,0,sizeof(buffer)); // reset all buffer to 0
    memset(data,0,sizeof(data)); // reset all buffer to 0
    if (uart0_send_command(TEST_CMD)) {
        while (1) {
            uart1_gets(buffer, sizeof(buffer));
            start = strstr(buffer, "START_MSG");
            end = strstr(buffer,"END_MSG");
            if (start!=NULL && end!=NULL) {
                *end = '\0'; // stop the string after the end signal
                strcpy(data,start); // extract the data from the package
                printf("data:\r\n%s\r\n", data);
                printf("Test Successful.\r\n");
                break;
            } else {

                printf("Test failed. Trying again...\r\n");
                printf("Full buffer:\r\n%s\r\n", buffer);
                usleep(1 * 500 * 1000);
            }
        }
    }
    
    // test cJSON
    // const cJSON *id = NULL;
    // const cJSON *temp = NULL;
    // // const cJSON *soil = NULL;
    // // const cJSON *light = NULL;
    // // const cJSON *eco2 = NULL;
    // // const cJSON *evoc = NULL;
    
    // cJSON *data_json = cJSON_Parse(data);
    // if (data_json == NULL) {
    //     const char *error_ptr = cJSON_GetErrorPtr();
    //     if (error_ptr != NULL) {
    //         printf("Error before: %s\n", error_ptr);
    //     }
    //     goto end;
    // }

    // id = cJSON_GetObjectItemCaseSensitive(data_json, "id");
    // temp = cJSON_GetObjectItemCaseSensitive(data_json, "temp");
    // if (cJSON_IsNumber(id) && (id->valueint != NULL))
    // {
    //     printf("device \"%d\" temperature is %.3f celcius degree\r\n", id->valueint, temp->valuedouble);
    //     printf("Testing cJSON done.");
    // }
    // end:
    // cJSON_Delete(data_json);
    // return;
}
// const char *time_server_domain = "demo.terasic.com";

/*
const char *get_time_request =
        "GET /time/ HTTP/1.1\r\n\
Host: demo.terasic.com\r\n\
User-Agent: terasic-rfs\r\n\
\r\n\
";
*/
// char *get_time(char *str)
// {
//     bool success = true;
//     char cmd_buffer[100];
//     char buffer[1000];
//     if (success) {
//         sprintf(cmd_buffer, "AT+CIPSTART=\"TCP\",\"%s\",80",
//                 time_server_domain);
//         success = uart_send_command(cmd_buffer);
//     }
//     if (success) {
//         sprintf(cmd_buffer, "AT+CIPSEND=%d", strlen(get_time_request));
//         success = uart_send_command(cmd_buffer);
//     }
//     if (success) {
//         success = uart_send_data(get_time_request, strlen(get_time_request));
//     }

//     int length = 0;

//     if (success) {
//         while (1) {
//             uart_gets(buffer, sizeof(buffer));
//             if (strstr(buffer, "+IPD") != NULL) {
//                 length = strlen(buffer);
//                 while (1) {
//                     uart_gets(buffer + length, sizeof(buffer) - length);
//                     if (strcmp(buffer + length, "\r\n") == 0)
//                         break;
//                     length += strlen(buffer + length);
//                 }
//                 break;
//             }
//         }
//         uart_gets(buffer, 9);
//         printf("time: %s\n", buffer);
//     }

//     if (success) {
//         strcpy(str, buffer);
//         return str;
//     } else {
//         return NULL;
//     }
// }
