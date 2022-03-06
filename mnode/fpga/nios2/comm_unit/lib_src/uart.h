/*
 * uart.h
 *
 *  Created on: 2016/10/7
 *      Author: User
 */

#ifndef uart_H_
#define uart_H_

#include <stdbool.h>

bool uart_init(bool reset);
bool uart_send_command(const char *cmd);
bool uart_send_data(const char *data, int length);
void uart_dump_rx();
void uart_listen();
char *uart_gets(char *buffer, int buffer_size);

#endif /* uart_H_ */
