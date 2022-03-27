/*------------------------------------------------------------*-
  
  Copyright(c) Minh-An Dao 2022. All Rights Reserved.

---------------------------------------------------------------*/
/**
 * @file      uart.h
 * @brief     
 * @version   $Revision: 1.00 $
 * @date      $Date: 10/3/2022 $
 * @details
 *            - Inherited from Intel Example Source code
 *
 --------------------------------------------------------------*/
#ifndef __UART_H
#define __UART_H

// #pragma once

#include <stdbool.h>

// ------ Public constants ------------------------------------
#define UART0       0
#define UART1       1
// ------ Public function prototypes --------------------------
/**
 * @brief UART init function (public)
 */
// bool uarts_init(bool reset);
bool uarts_init(void);
/**
 * @brief uart
 */
bool uart0_send_command(const char *cmd);
/**
 * @brief uart
 */
bool uart1_send_command(const char *cmd);
/**
 * @brief uart
 */
bool uart0_send_data(const char *data, int length);
/**
 * @brief uart
 */
bool uart1_send_data(const char *data, int length);

/**
 * @brief uart
 */
char *uart0_gets(char *buffer, int buffer_size);
/**
 * @brief uart
 */
char *uart1_gets(char *buffer, int buffer_size);

// ------ Public variables -------------------------------------



#endif /* __UART_H */
