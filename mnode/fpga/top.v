/*
 * Modified 
 * Copyright (C) 2021 Intel Corporation 
 * Licensed under the MIT license. See LICENSE file in the project root for
 * full license information.

 * Origin(Terasic)
 * See Copyright.txt file in the <project root/LICENSES/origin/de10nano-samples> for
 * full license information.

 * //=======================================================
 * //  This code is generated by Terasic System Builder
 * //=======================================================
*/

module top(

    //////////// CLOCK //////////
    input               FPGA_CLK1_50,
    input               FPGA_CLK2_50,
    input               FPGA_CLK3_50,

    //////////// KEY //////////
    input    [ 1: 0]    KEY,

    //////////// LED //////////
    output   [ 7: 0]    LED,

    //////////// SW //////////
    input    [ 3: 0]    SW, 

    //////////// HDMI //////////
    // inout               HDMI_I2C_SCL,
    // inout               HDMI_I2C_SDA,
    // inout               HDMI_I2S,
    // inout               HDMI_LRCLK,
    // inout               HDMI_MCLK,
    // inout               HDMI_SCLK,
    // output              HDMI_TX_CLK,
    // output   [23: 0]    HDMI_TX_D,
    // output              HDMI_TX_DE,
    // output              HDMI_TX_HS,
    // input               HDMI_TX_INT,
    // output              HDMI_TX_VS,

    //////////// HPS //////////
    inout               HPS_CONV_USB_N,
    output   [14: 0]    HPS_DDR3_ADDR,
    output   [ 2: 0]    HPS_DDR3_BA,
    output              HPS_DDR3_CAS_N,
    output              HPS_DDR3_CK_N,
    output              HPS_DDR3_CK_P,
    output              HPS_DDR3_CKE,
    output              HPS_DDR3_CS_N,
    output   [ 3: 0]    HPS_DDR3_DM,
    inout    [31: 0]    HPS_DDR3_DQ,
    inout    [ 3: 0]    HPS_DDR3_DQS_N,
    inout    [ 3: 0]    HPS_DDR3_DQS_P,
    output              HPS_DDR3_ODT,
    output              HPS_DDR3_RAS_N,
    output              HPS_DDR3_RESET_N,
    input               HPS_DDR3_RZQ,
    output              HPS_DDR3_WE_N,
    output              HPS_ENET_GTX_CLK,
    inout               HPS_ENET_INT_N,
    output              HPS_ENET_MDC,
    inout               HPS_ENET_MDIO,
    input               HPS_ENET_RX_CLK,
    input    [ 3: 0]    HPS_ENET_RX_DATA,
    input               HPS_ENET_RX_DV,
    output   [ 3: 0]    HPS_ENET_TX_DATA,
    output              HPS_ENET_TX_EN,
    inout               HPS_GSENSOR_INT,
    inout               HPS_I2C0_SCLK,
    inout               HPS_I2C0_SDAT,
    inout               HPS_I2C1_SCLK,
    inout               HPS_I2C1_SDAT,
    inout               HPS_KEY,
    inout               HPS_LED,
    inout               HPS_LTC_GPIO,
    output              HPS_SD_CLK,
    inout               HPS_SD_CMD,
    inout    [ 3: 0]    HPS_SD_DATA,
    output              HPS_SPIM_CLK,
    input               HPS_SPIM_MISO,
    output              HPS_SPIM_MOSI,
    inout               HPS_SPIM_SS,
    input               HPS_UART_RX,
    output              HPS_UART_TX,
    input               HPS_USB_CLKOUT,
    inout    [ 7: 0]    HPS_USB_DATA,
    input               HPS_USB_DIR,
    input               HPS_USB_NXT,
    output              HPS_USB_STP,

    //////////// RS485 Nios no1 //////////
    //directly using the TMP pins instead
    // input 		          		NIOS_UART0_RXD,
    // output		          		NIOS_UART0_TXD,

    // //////////// RS485 Nios no2 //////////
    // input 		          		NIOS_UART1_RXD,
    // output		          		NIOS_UART1_TXD,
    
    // //////////// RS485 Nios no2 //////////
	//  output    [ 3:0]  			  RELAY,
    /////////// RFS card interface signals //////
    input                       LSENSOR_INT,
    inout                       LSENSOR_SCL,
    inout                       LSENSOR_SDA,
    inout                       MPU_AD0_SDO,
    output                      MPU_CS_n,
    output                      MPU_FSYNC,
    input                       MPU_INT,
    inout                       MPU_SCL_SCLK,
    inout                       MPU_SDA_SDI,
    input                       RH_TEMP_DRDY_n,
    inout                       RH_TEMP_I2C_SCL,
    inout                       RH_TEMP_I2C_SDA,
    //// unused signals in this design ////
    // inout 		          		BT_KEY,
    // input 		          		BT_UART_RX,
    // output		          		BT_UART_TX,
    inout 		     [7:0]		TMD_D,
    input 		          		UART2USB_CTS,
    output		          		UART2USB_RTS,
    input 		          		UART2USB_RX,
    output		          		UART2USB_TX
    // output		          		WIFI_EN,
    // output		          		WIFI_RST_n,
    // input 		          		WIFI_UART0_CTS,
    // output		          		WIFI_UART0_RTS,
    // input 		          		WIFI_UART0_RX,
    // output		          		WIFI_UART0_TX,
    // input 		          		WIFI_UART1_RX
);

assign MPU_CS_n = 1'b1;
assign MPU_FSYNC = 1'b0;
assign MPU_AD0_SDO = 1'b0;


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire hps_fpga_reset_n;
wire     [1: 0]     fpga_debounced_buttons;
wire     [6: 0]     fpga_led_for_hps_internal;
wire     [2: 0]     hps_reset_req;
wire                hps_cold_reset;
wire                hps_warm_reset;
wire                hps_debug_reset;
wire     [27: 0]    stm_hw_events;
wire                fpga_clk_50;

wire      [7:0]     fpga_led_for_nios_comm;
wire      [7:0]     fpga_led_for_nios_sensor;


// Wires for shared memory access beteen HPS sytem and NiosII system //
// wire pio_wifi_reset;
// wire [3:0] pio_relay;

wire		shared_mem_bridge_waitrequest;
wire	[31:0]	shared_mem_bridge_readdata;
wire		shared_mem_bridge_readdatavalid;
wire	[0:0]	shared_mem_bridge_burstcount;
wire	[31:0]	shared_mem_bridge_writedata;
wire	[17:0]	shared_mem_bridge_address;
wire		shared_mem_bridge_write;
wire		shared_mem_bridge_read;
wire	[3:0]	shared_mem_bridge_byteenable;
wire		shared_mem_bridge_debugaccess;

wire		nios2_comm_resetreq_pio_wire;
wire		nios2_comm_resettaken_pio_wire;
wire		nios2_resetreq_pio_wire;
wire		nios2_resettaken_pio_wire;

// connection of internal logics
assign fpga_clk_50 = FPGA_CLK1_50;
assign stm_hw_events = {{15{1'b0}}, SW, fpga_led_for_hps_internal, fpga_debounced_buttons};

// assign RELAY = pio_relay;
// assign WIFI_RST_n = KEY[0] & pio_wifi_reset;
// assign WIFI_EN = 1'b1;

// assign LED[6] = ~WIFI_UART0_TX;
// assign LED[7] = ~WIFI_UART0_RX;

// assign UART2USB_TX = ((SW[0] == 1'b0)? WIFI_UART0_RX: WIFI_UART0_TX);

//=======================================================
//  Structural coding
//=======================================================
qsys_top u0 (
        //Clock&Reset
        .clk_clk                                                                 (FPGA_CLK1_50),                                      //                            clk.clk
        .reset_reset_n                                                           (hps_fpga_reset_n),                            //                          reset.reset_n
        //HPS ethernet
        .hps_io_hps_io_emac1_inst_TX_CLK                                         (HPS_ENET_GTX_CLK),    //                   hps_io.hps_io_emac1_inst_TX_CLK
        .hps_io_hps_io_emac1_inst_TXD0                                           (HPS_ENET_TX_DATA[0]),   //                               .hps_io_emac1_inst_TXD0
        .hps_io_hps_io_emac1_inst_TXD1                                           (HPS_ENET_TX_DATA[1]),   //                               .hps_io_emac1_inst_TXD1
        .hps_io_hps_io_emac1_inst_TXD2                                           (HPS_ENET_TX_DATA[2]),   //                               .hps_io_emac1_inst_TXD2
        .hps_io_hps_io_emac1_inst_TXD3                                           (HPS_ENET_TX_DATA[3]),   //                               .hps_io_emac1_inst_TXD3
        .hps_io_hps_io_emac1_inst_RXD0                                           (HPS_ENET_RX_DATA[0]),   //                               .hps_io_emac1_inst_RXD0
        .hps_io_hps_io_emac1_inst_MDIO                                           (HPS_ENET_MDIO),         //                               .hps_io_emac1_inst_MDIO
        .hps_io_hps_io_emac1_inst_MDC                                            (HPS_ENET_MDC),           //                               .hps_io_emac1_inst_MDC
        .hps_io_hps_io_emac1_inst_RX_CTL                                         (HPS_ENET_RX_DV),      //                               .hps_io_emac1_inst_RX_CTL
        .hps_io_hps_io_emac1_inst_TX_CTL                                         (HPS_ENET_TX_EN),      //                               .hps_io_emac1_inst_TX_CTL
        .hps_io_hps_io_emac1_inst_RX_CLK                                         (HPS_ENET_RX_CLK),     //                               .hps_io_emac1_inst_RX_CLK
        .hps_io_hps_io_emac1_inst_RXD1                                           (HPS_ENET_RX_DATA[1]),   //                               .hps_io_emac1_inst_RXD1
        .hps_io_hps_io_emac1_inst_RXD2                                           (HPS_ENET_RX_DATA[2]),   //                               .hps_io_emac1_inst_RXD2
        .hps_io_hps_io_emac1_inst_RXD3                                           (HPS_ENET_RX_DATA[3]),   //                               .hps_io_emac1_inst_RXD3
        //HPS SD card
        .hps_io_hps_io_sdio_inst_CMD                                             (HPS_SD_CMD),              //                               .hps_io_sdio_inst_CMD
        .hps_io_hps_io_sdio_inst_D0                                              (HPS_SD_DATA[0]),           //                               .hps_io_sdio_inst_D0
        .hps_io_hps_io_sdio_inst_D1                                              (HPS_SD_DATA[1]),           //                               .hps_io_sdio_inst_D1
        .hps_io_hps_io_sdio_inst_CLK                                             (HPS_SD_CLK),              //                               .hps_io_sdio_inst_CLK
        .hps_io_hps_io_sdio_inst_D2                                              (HPS_SD_DATA[2]),           //                               .hps_io_sdio_inst_D2
        .hps_io_hps_io_sdio_inst_D3                                              (HPS_SD_DATA[3]),           //                               .hps_io_sdio_inst_D3
        //HPS USB
        .hps_io_hps_io_usb1_inst_D0                                              (HPS_USB_DATA[0]),          //                               .hps_io_usb1_inst_D0
        .hps_io_hps_io_usb1_inst_D1                                              (HPS_USB_DATA[1]),          //                               .hps_io_usb1_inst_D1
        .hps_io_hps_io_usb1_inst_D2                                              (HPS_USB_DATA[2]),          //                               .hps_io_usb1_inst_D2
        .hps_io_hps_io_usb1_inst_D3                                              (HPS_USB_DATA[3]),          //                               .hps_io_usb1_inst_D3
        .hps_io_hps_io_usb1_inst_D4                                              (HPS_USB_DATA[4]),          //                               .hps_io_usb1_inst_D4
        .hps_io_hps_io_usb1_inst_D5                                              (HPS_USB_DATA[5]),          //                               .hps_io_usb1_inst_D5
        .hps_io_hps_io_usb1_inst_D6                                              (HPS_USB_DATA[6]),          //                               .hps_io_usb1_inst_D6
        .hps_io_hps_io_usb1_inst_D7                                              (HPS_USB_DATA[7]),          //                               .hps_io_usb1_inst_D7
        .hps_io_hps_io_usb1_inst_CLK                                             (HPS_USB_CLKOUT),          //                               .hps_io_usb1_inst_CLK
        .hps_io_hps_io_usb1_inst_STP                                             (HPS_USB_STP),             //                               .hps_io_usb1_inst_STP
        .hps_io_hps_io_usb1_inst_DIR                                             (HPS_USB_DIR),             //                               .hps_io_usb1_inst_DIR
        .hps_io_hps_io_usb1_inst_NXT                                             (HPS_USB_NXT),             //                               .hps_io_usb1_inst_NXT
        //HPS SPI
        .hps_io_hps_io_spim1_inst_CLK                                            (HPS_SPIM_CLK),           //                               .hps_io_spim1_inst_CLK
        .hps_io_hps_io_spim1_inst_MOSI                                           (HPS_SPIM_MOSI),         //                               .hps_io_spim1_inst_MOSI
        .hps_io_hps_io_spim1_inst_MISO                                           (HPS_SPIM_MISO),         //                               .hps_io_spim1_inst_MISO
        .hps_io_hps_io_spim1_inst_SS0                                            (HPS_SPIM_SS),            //                               .hps_io_spim1_inst_SS0
        //HPS UART
        .hps_io_hps_io_uart0_inst_RX                                             (HPS_UART_RX),             //                               .hps_io_uart0_inst_RX
        .hps_io_hps_io_uart0_inst_TX                                             (HPS_UART_TX),             //                               .hps_io_uart0_inst_TX
        //HPS I2C1
        .hps_io_hps_io_i2c0_inst_SDA                                             (HPS_I2C0_SDAT),           //                               .hps_io_i2c0_inst_SDA
        .hps_io_hps_io_i2c0_inst_SCL                                             (HPS_I2C0_SCLK),           //                               .hps_io_i2c0_inst_SCL
        //HPS I2C2
        .hps_io_hps_io_i2c1_inst_SDA                                             (HPS_I2C1_SDAT),           //                               .hps_io_i2c1_inst_SDA
        .hps_io_hps_io_i2c1_inst_SCL                                             (HPS_I2C1_SCLK),           //                               .hps_io_i2c1_inst_SCL
        //GPIO
        .hps_io_hps_io_gpio_inst_GPIO09                                          (HPS_CONV_USB_N),       //                               .hps_io_gpio_inst_GPIO09
        .hps_io_hps_io_gpio_inst_GPIO35                                          (HPS_ENET_INT_N),       //                               .hps_io_gpio_inst_GPIO35
        .hps_io_hps_io_gpio_inst_GPIO40                                          (HPS_LTC_GPIO),         //                               .hps_io_gpio_inst_GPIO40
        .hps_io_hps_io_gpio_inst_GPIO53                                          (HPS_LED),              //                               .hps_io_gpio_inst_GPIO53
        .hps_io_hps_io_gpio_inst_GPIO54                                          (HPS_KEY),              //                               .hps_io_gpio_inst_GPIO54
        .hps_io_hps_io_gpio_inst_GPIO61                                          (HPS_GSENSOR_INT),      //                               .hps_io_gpio_inst_GPIO61
        //FPGA Partion
        .hps_system_led_pio_external_connection_export                           (fpga_led_for_hps_internal),                           //                 hps_system_led_pio_external_connection.export
        .hps_system_button_pio_external_connection_export                        (fpga_debounced_buttons),                        //              hps_system_button_pio_external_connection.export
        .hps_system_dipsw_pio_external_connection_export                         (SW),                         //               hps_system_dipsw_pio_external_connection.export
        
        .hps_system_hps_0_f2h_warm_reset_req_reset_n                             (~hps_warm_reset),                             //                    hps_system_hps_0_f2h_warm_reset_req.reset_n
        .hps_system_hps_0_f2h_cold_reset_req_reset_n                             (~hps_cold_reset),                             //                    hps_system_hps_0_f2h_cold_reset_req.reset_n
        .hps_system_hps_0_f2h_debug_reset_req_reset_n                            (~hps_debug_reset),                            //                   hps_system_hps_0_f2h_debug_reset_req.reset_n
        .hps_system_hps_0_f2h_stm_hw_events_stm_hwevents                         (stm_hw_events),                         //                     hps_system_hps_0_f2h_stm_hw_events.stm_hwevents
        .hps_system_hps_0_h2f_reset_reset_n                                      (hps_fpga_reset_n),                                      //                             hps_system_hps_0_h2f_reset.reset_n
        
        .hps_system_nios2_comm_resetreq_pio_external_connection_export           (nios2_comm_resetreq_pio_wire),                //      hps_system_nios2_resetreq_pio_external_connection.export
        .hps_system_nios2_comm_resettaken_pio_external_connection_export         (nios2_comm_resettaken_pio_wire),              //    hps_system_nios2_resettaken_pio_external_connection.export
        .hps_system_nios2_sensor_resetreq_pio_external_connection_export         (nios2_resetreq_pio_wire),                //      hps_system_nios2_resetreq_pio_external_connection.export
        .hps_system_nios2_sensor_resettaken_pio_external_connection_export       (nios2_resettaken_pio_wire),              //    hps_system_nios2_resettaken_pio_external_connection.export
        //HPS ddr3
        .memory_mem_a                                                            (HPS_DDR3_ADDR),                                //                         memory.mem_a
        .memory_mem_ba                                                           (HPS_DDR3_BA),                                 //                               .mem_ba
        .memory_mem_ck                                                           (HPS_DDR3_CK_P),                               //                               .mem_ck
        .memory_mem_ck_n                                                         (HPS_DDR3_CK_N),                             //                               .mem_ck_n
        .memory_mem_cke                                                          (HPS_DDR3_CKE),                               //                               .mem_cke
        .memory_mem_cs_n                                                         (HPS_DDR3_CS_N),                             //                               .mem_cs_n
        .memory_mem_ras_n                                                        (HPS_DDR3_RAS_N),                           //                               .mem_ras_n
        .memory_mem_cas_n                                                        (HPS_DDR3_CAS_N),                           //                               .mem_cas_n
        .memory_mem_we_n                                                         (HPS_DDR3_WE_N),                             //                               .mem_we_n
        .memory_mem_reset_n                                                      (HPS_DDR3_RESET_N),                       //                               .mem_reset_n
        .memory_mem_dq                                                           (HPS_DDR3_DQ),                                 //                               .mem_dq
        .memory_mem_dqs                                                          (HPS_DDR3_DQS_P),                             //                               .mem_dqs
        .memory_mem_dqs_n                                                        (HPS_DDR3_DQS_N),                           //                               .mem_dqs_n
        .memory_mem_odt                                                          (HPS_DDR3_ODT),                               //                               .mem_odt
        .memory_mem_dm                                                           (HPS_DDR3_DM),                                 //                               .mem_dm
        .memory_oct_rzqin                                                        (HPS_DDR3_RZQ),                             //                               .oct_rzqin
        // --- Communication Nios core
        .nios_comm_system_led_pio_export                                         (fpga_led_for_nios_comm),                                         //                               nios_comm_system_led_pio.export
        .nios_comm_system_nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest   (nios2_comm_resetreq_pio_wire),   //   nios_comm_system_nios2_gen2_cpu_resetrequest_conduit.cpu_resetrequest
        .nios_comm_system_nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken     (nios2_comm_resettaken_pio_wire),     //                                                       .cpu_resettaken
        
        // .nios_comm_system_rs485_uart_0_external_connection_rxd                   (NIOS_UART0_RXD),                 //    nios_comm_system_rs485_uart_0_external_connection_1.rxd
        // .nios_comm_system_rs485_uart_0_external_connection_txd                   (NIOS_UART0_TXD),                 //                                                       .txd
        
        // .nios_comm_system_rs485_uart_1_external_connection_rxd                   (NIOS_UART1_RXD),                   //      nios_comm_system_rs485_uart_1_external_connection.rxd
        // .nios_comm_system_rs485_uart_1_external_connection_txd                   (NIOS_UART1_TXD),                   //                                                       .txd
        .nios_comm_system_rs485_uart_0_external_connection_rxd                   (TMD_D[3]),                 //    nios_comm_system_rs485_uart_0_external_connection_1.rxd
        .nios_comm_system_rs485_uart_0_external_connection_txd                   (TMD_D[7]),                 //                                                       .txd
        
		.nios_comm_system_rs485_uart_1_external_connection_rxd                   (TMD_D[2]),                   //      nios_comm_system_rs485_uart_1_external_connection.rxd
        .nios_comm_system_rs485_uart_1_external_connection_txd                   (TMD_D[1]),                   //                                                       .txd
        
        // .nios_comm_system_pio_relays_external_connection_export                  (pio_relay),                  //            nios_comm_system_pio_relays_external_connection.export

		//.nios_comm_system_rs485_uart_0_external_connection_rxd                   (WIFI_UART0_RX),                 //    nios_comm_system_rs485_uart_0_external_connection_1.rxd
      //  .nios_comm_system_rs485_uart_0_external_connection_txd                   (WIFI_UART0_TX),                 // .txd
       // .nios_comm_system_rs485_uart_0_external_connection_cts_n                 (WIFI_UART0_CTS),                 // .cts_n
       // .nios_comm_system_rs485_uart_0_external_connection_rts_n                 (WIFI_UART0_RTS), // .rts_n
		//.nios_comm_system_pio_wifi_reset_external_connection_export            (pio_wifi_reset),            //  pio_wifi_reset_external_connection.export
        
        // --- Sensor Nios core
        .nios_sensor_system_led_pio_export                                       (fpga_led_for_nios_sensor),                                       //                             nios_sensor_system_led_pio.export
        .nios_sensor_system_nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest (nios2_resetreq_pio_wire), // nios_sensor_system_nios2_gen2_cpu_resetrequest_conduit.cpu_resetrequest
        .nios_sensor_system_nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken   (nios2_resettaken_pio_wire),   //                                                       .cpu_resettaken
        .nios_sensor_system_light_i2c_opencores_export_scl_pad_io                (LSENSOR_SCL),                //          nios_sensor_system_light_i2c_opencores_export.scl_pad_io
        
        .nios_sensor_system_light_i2c_opencores_export_sda_pad_io                (LSENSOR_SDA),                //                                                       .sda_pad_io
        .nios_sensor_system_light_int_external_connection_export                 (LSENSOR_INT),                 //       nios_sensor_system_light_int_external_connection.export
        
        .nios_sensor_system_mpu_i2c_opencores_export_scl_pad_io                  (MPU_SCL_SCLK),                  //            nios_sensor_system_mpu_i2c_opencores_export.scl_pad_io
        .nios_sensor_system_mpu_i2c_opencores_export_sda_pad_io                  (MPU_SDA_SDI),                  //                                                       .sda_pad_io
        .nios_sensor_system_mpu_int_external_connection_export                   (MPU_INT),                   //         nios_sensor_system_mpu_int_external_connection.export
        
        .nios_sensor_system_rh_temp_drdy_n_external_connection_export            (RH_TEMP_DRDY_n),            //  nios_sensor_system_rh_temp_drdy_n_external_connection.export
        .nios_sensor_system_rh_temp_i2c_opencores_export_scl_pad_io              (RH_TEMP_I2C_SCL),              //        nios_sensor_system_rh_temp_i2c_opencores_export.scl_pad_io
        .nios_sensor_system_rh_temp_i2c_opencores_export_sda_pad_io              (RH_TEMP_I2C_SDA),              //                                                       .sda_pad_io

    );

// top_qsys u0(
//                //Clock&Reset
//                .clk_clk(FPGA_CLK1_50),                                      //                            clk.clk
//                .reset_reset_n(hps_fpga_reset_n),                            //                          reset.reset_n
//                //HPS ddr3
//                .memory_mem_a(HPS_DDR3_ADDR),                                //                         memory.mem_a
//                .memory_mem_ba(HPS_DDR3_BA),                                 //                               .mem_ba
//                .memory_mem_ck(HPS_DDR3_CK_P),                               //                               .mem_ck
//                .memory_mem_ck_n(HPS_DDR3_CK_N),                             //                               .mem_ck_n
//                .memory_mem_cke(HPS_DDR3_CKE),                               //                               .mem_cke
//                .memory_mem_cs_n(HPS_DDR3_CS_N),                             //                               .mem_cs_n
//                .memory_mem_ras_n(HPS_DDR3_RAS_N),                           //                               .mem_ras_n
//                .memory_mem_cas_n(HPS_DDR3_CAS_N),                           //                               .mem_cas_n
//                .memory_mem_we_n(HPS_DDR3_WE_N),                             //                               .mem_we_n
//                .memory_mem_reset_n(HPS_DDR3_RESET_N),                       //                               .mem_reset_n
//                .memory_mem_dq(HPS_DDR3_DQ),                                 //                               .mem_dq
//                .memory_mem_dqs(HPS_DDR3_DQS_P),                             //                               .mem_dqs
//                .memory_mem_dqs_n(HPS_DDR3_DQS_N),                           //                               .mem_dqs_n
//                .memory_mem_odt(HPS_DDR3_ODT),                               //                               .mem_odt
//                .memory_mem_dm(HPS_DDR3_DM),                                 //                               .mem_dm
//                .memory_oct_rzqin(HPS_DDR3_RZQ),                             //                               .oct_rzqin
//                //HPS ethernet
//                .hps_io_hps_io_emac1_inst_TX_CLK(HPS_ENET_GTX_CLK),    //                   hps_io.hps_io_emac1_inst_TX_CLK
//                .hps_io_hps_io_emac1_inst_TXD0(HPS_ENET_TX_DATA[0]),   //                               .hps_io_emac1_inst_TXD0
//                .hps_io_hps_io_emac1_inst_TXD1(HPS_ENET_TX_DATA[1]),   //                               .hps_io_emac1_inst_TXD1
//                .hps_io_hps_io_emac1_inst_TXD2(HPS_ENET_TX_DATA[2]),   //                               .hps_io_emac1_inst_TXD2
//                .hps_io_hps_io_emac1_inst_TXD3(HPS_ENET_TX_DATA[3]),   //                               .hps_io_emac1_inst_TXD3
//                .hps_io_hps_io_emac1_inst_RXD0(HPS_ENET_RX_DATA[0]),   //                               .hps_io_emac1_inst_RXD0
//                .hps_io_hps_io_emac1_inst_MDIO(HPS_ENET_MDIO),         //                               .hps_io_emac1_inst_MDIO
//                .hps_io_hps_io_emac1_inst_MDC(HPS_ENET_MDC),           //                               .hps_io_emac1_inst_MDC
//                .hps_io_hps_io_emac1_inst_RX_CTL(HPS_ENET_RX_DV),      //                               .hps_io_emac1_inst_RX_CTL
//                .hps_io_hps_io_emac1_inst_TX_CTL(HPS_ENET_TX_EN),      //                               .hps_io_emac1_inst_TX_CTL
//                .hps_io_hps_io_emac1_inst_RX_CLK(HPS_ENET_RX_CLK),     //                               .hps_io_emac1_inst_RX_CLK
//                .hps_io_hps_io_emac1_inst_RXD1(HPS_ENET_RX_DATA[1]),   //                               .hps_io_emac1_inst_RXD1
//                .hps_io_hps_io_emac1_inst_RXD2(HPS_ENET_RX_DATA[2]),   //                               .hps_io_emac1_inst_RXD2
//                .hps_io_hps_io_emac1_inst_RXD3(HPS_ENET_RX_DATA[3]),   //                               .hps_io_emac1_inst_RXD3
//                //HPS SD card
//                .hps_io_hps_io_sdio_inst_CMD(HPS_SD_CMD),              //                               .hps_io_sdio_inst_CMD
//                .hps_io_hps_io_sdio_inst_D0(HPS_SD_DATA[0]),           //                               .hps_io_sdio_inst_D0
//                .hps_io_hps_io_sdio_inst_D1(HPS_SD_DATA[1]),           //                               .hps_io_sdio_inst_D1
//                .hps_io_hps_io_sdio_inst_CLK(HPS_SD_CLK),              //                               .hps_io_sdio_inst_CLK
//                .hps_io_hps_io_sdio_inst_D2(HPS_SD_DATA[2]),           //                               .hps_io_sdio_inst_D2
//                .hps_io_hps_io_sdio_inst_D3(HPS_SD_DATA[3]),           //                               .hps_io_sdio_inst_D3
//                //HPS USB
//                .hps_io_hps_io_usb1_inst_D0(HPS_USB_DATA[0]),          //                               .hps_io_usb1_inst_D0
//                .hps_io_hps_io_usb1_inst_D1(HPS_USB_DATA[1]),          //                               .hps_io_usb1_inst_D1
//                .hps_io_hps_io_usb1_inst_D2(HPS_USB_DATA[2]),          //                               .hps_io_usb1_inst_D2
//                .hps_io_hps_io_usb1_inst_D3(HPS_USB_DATA[3]),          //                               .hps_io_usb1_inst_D3
//                .hps_io_hps_io_usb1_inst_D4(HPS_USB_DATA[4]),          //                               .hps_io_usb1_inst_D4
//                .hps_io_hps_io_usb1_inst_D5(HPS_USB_DATA[5]),          //                               .hps_io_usb1_inst_D5
//                .hps_io_hps_io_usb1_inst_D6(HPS_USB_DATA[6]),          //                               .hps_io_usb1_inst_D6
//                .hps_io_hps_io_usb1_inst_D7(HPS_USB_DATA[7]),          //                               .hps_io_usb1_inst_D7
//                .hps_io_hps_io_usb1_inst_CLK(HPS_USB_CLKOUT),          //                               .hps_io_usb1_inst_CLK
//                .hps_io_hps_io_usb1_inst_STP(HPS_USB_STP),             //                               .hps_io_usb1_inst_STP
//                .hps_io_hps_io_usb1_inst_DIR(HPS_USB_DIR),             //                               .hps_io_usb1_inst_DIR
//                .hps_io_hps_io_usb1_inst_NXT(HPS_USB_NXT),             //                               .hps_io_usb1_inst_NXT
//                //HPS SPI
//                .hps_io_hps_io_spim1_inst_CLK(HPS_SPIM_CLK),           //                               .hps_io_spim1_inst_CLK
//                .hps_io_hps_io_spim1_inst_MOSI(HPS_SPIM_MOSI),         //                               .hps_io_spim1_inst_MOSI
//                .hps_io_hps_io_spim1_inst_MISO(HPS_SPIM_MISO),         //                               .hps_io_spim1_inst_MISO
//                .hps_io_hps_io_spim1_inst_SS0(HPS_SPIM_SS),            //                               .hps_io_spim1_inst_SS0
//                //HPS UART
//                .hps_io_hps_io_uart0_inst_RX(HPS_UART_RX),             //                               .hps_io_uart0_inst_RX
//                .hps_io_hps_io_uart0_inst_TX(HPS_UART_TX),             //                               .hps_io_uart0_inst_TX
//                //HPS I2C1
//                .hps_io_hps_io_i2c0_inst_SDA(HPS_I2C0_SDAT),           //                               .hps_io_i2c0_inst_SDA
//                .hps_io_hps_io_i2c0_inst_SCL(HPS_I2C0_SCLK),           //                               .hps_io_i2c0_inst_SCL
//                //HPS I2C2
//                .hps_io_hps_io_i2c1_inst_SDA(HPS_I2C1_SDAT),           //                               .hps_io_i2c1_inst_SDA
//                .hps_io_hps_io_i2c1_inst_SCL(HPS_I2C1_SCLK),           //                               .hps_io_i2c1_inst_SCL
//                //GPIO
//                .hps_io_hps_io_gpio_inst_GPIO09(HPS_CONV_USB_N),       //                               .hps_io_gpio_inst_GPIO09
//                .hps_io_hps_io_gpio_inst_GPIO35(HPS_ENET_INT_N),       //                               .hps_io_gpio_inst_GPIO35
//                .hps_io_hps_io_gpio_inst_GPIO40(HPS_LTC_GPIO),         //                               .hps_io_gpio_inst_GPIO40
//                .hps_io_hps_io_gpio_inst_GPIO53(HPS_LED),              //                               .hps_io_gpio_inst_GPIO53
//                .hps_io_hps_io_gpio_inst_GPIO54(HPS_KEY),              //                               .hps_io_gpio_inst_GPIO54
//                .hps_io_hps_io_gpio_inst_GPIO61(HPS_GSENSOR_INT),      //                               .hps_io_gpio_inst_GPIO61
//                //FPGA Partion
//                .hps_system_led_pio_external_connection_export(fpga_led_for_hps_internal),      //    led_pio_external_connection.export
//                .hps_system_dipsw_pio_external_connection_export(SW),                   //  dipsw_pio_external_connection.export
//                .hps_system_button_pio_external_connection_export(fpga_debounced_buttons),
//                                                                             // button_pio_external_connection.export
//                .hps_system_hps_0_h2f_reset_reset_n(hps_fpga_reset_n),                  //                hps_system_h2f_reset.reset_n
//                .hps_system_hps_0_f2h_cold_reset_req_reset_n(~hps_cold_reset),          //       hps_system_f2h_cold_reset_req.reset_n
//                .hps_system_hps_0_f2h_debug_reset_req_reset_n(~hps_debug_reset),        //      hps_system_f2h_debug_reset_req.reset_n
//                .hps_system_hps_0_f2h_stm_hw_events_stm_hwevents(stm_hw_events),        //        hps_system_f2h_stm_hw_events.stm_hwevents
//                .hps_system_hps_0_f2h_warm_reset_req_reset_n(~hps_warm_reset),          //       hps_system_f2h_warm_reset_req.reset_n

//                .hps_system_nios2_resetreq_pio_external_connection_export   (nios2_resetreq_pio_wire),   
//                .hps_system_nios2_resettaken_pio_external_connection_export (nios2_resettaken_pio_wire),  

//                .nios_system_nios2_gen2_cpu_resetrequest_conduit_cpu_resetrequest (nios2_resetreq_pio_wire), 
//                .nios_system_nios2_gen2_cpu_resetrequest_conduit_cpu_resettaken   (nios2_resettaken_pio_wire),   


//                .nios_system_mpu_i2c_opencores_export_scl_pad_io        (MPU_SCL_SCLK),                 //                     mpu_i2c_export.scl_pad_io
//                .nios_system_mpu_i2c_opencores_export_sda_pad_io        (MPU_SDA_SDI),                 //                                   .sda_pad_io
//                .nios_system_mpu_int_external_connection_export         (MPU_INT),         //         mpu_int_external_connection.export

//                .nios_system_light_i2c_opencores_export_scl_pad_io      (LSENSOR_SCL),               //                   light_i2c_export.scl_pad_io
//                .nios_system_light_i2c_opencores_export_sda_pad_io      (LSENSOR_SDA),               //                                   .sda_pad_io
//                .nios_system_light_int_external_connection_export       (LSENSOR_INT),       //       light_int_external_connection.export

//                .nios_system_rh_temp_i2c_opencores_export_scl_pad_io    (RH_TEMP_I2C_SCL),             //                 rh_temp_i2c_export.scl_pad_io
//                .nios_system_rh_temp_i2c_opencores_export_sda_pad_io    (RH_TEMP_I2C_SDA),              //                                   .sda_pad_io
//                .nios_system_rh_temp_drdy_n_external_connection_export  (RH_TEMP_DRDY_n),   //  rh_temp_drdy_n_external_connection.export

//                .nios_system_led_pio_export                            (fpga_led_for_nios_internal),
//            );


// Debounce logic to clean out glitches within 1ms
debounce debounce_inst(
             .clk(fpga_clk_50),
             .reset_n(hps_fpga_reset_n),
             .data_in(KEY),
             .data_out(fpga_debounced_buttons)
         );
defparam debounce_inst.WIDTH = 2;
defparam debounce_inst.POLARITY = "LOW";
defparam debounce_inst.TIMEOUT = 50000;               // at 50Mhz this is a debounce time of 1ms
defparam debounce_inst.TIMEOUT_WIDTH = 16;            // ceil(log2(TIMEOUT))

// Source/Probe megawizard instance
hps_reset hps_reset_inst(
              .source_clk(fpga_clk_50),
              .source(hps_reset_req)
          );

altera_edge_detector pulse_cold_reset(
                         .clk(fpga_clk_50),
                         .rst_n(hps_fpga_reset_n),
                         .signal_in(hps_reset_req[0]),
                         .pulse_out(hps_cold_reset)
                     );
defparam pulse_cold_reset.PULSE_EXT = 6;
defparam pulse_cold_reset.EDGE_TYPE = 1;
defparam pulse_cold_reset.IGNORE_RST_WHILE_BUSY = 1;

altera_edge_detector pulse_warm_reset(
                         .clk(fpga_clk_50),
                         .rst_n(hps_fpga_reset_n),
                         .signal_in(hps_reset_req[1]),
                         .pulse_out(hps_warm_reset)
                     );
defparam pulse_warm_reset.PULSE_EXT = 2;
defparam pulse_warm_reset.EDGE_TYPE = 1;
defparam pulse_warm_reset.IGNORE_RST_WHILE_BUSY = 1;

altera_edge_detector pulse_debug_reset(
                         .clk(fpga_clk_50),
                         .rst_n(hps_fpga_reset_n),
                         .signal_in(hps_reset_req[2]),
                         .pulse_out(hps_debug_reset)
                     );
defparam pulse_debug_reset.PULSE_EXT = 32;
defparam pulse_debug_reset.EDGE_TYPE = 1;
defparam pulse_debug_reset.IGNORE_RST_WHILE_BUSY = 1;

// --- LED blinking
reg [25: 0] counter;
reg led_level;
always @(posedge fpga_clk_50 or negedge hps_fpga_reset_n) begin
    if (~hps_fpga_reset_n) begin
        counter <= 0;
        led_level <= 0;
    end

    else if (counter == 24999999) begin
        counter <= 0;
        led_level <= ~led_level;
    end
    else
        counter <= counter + 1'b1;
end

//assign LED[0] = led_level;
//assign LED[7: 0] = { fpga_led_for_nios_comm[1:0], fpga_led_for_nios_comm[1:0], fpga_led_for_hps_internal[2:0] , led_level};

// assign LED[7: 0] = { fpga_led_for_nios_internal[2:0], fpga_led_for_hps_internal[3:0] , led_level};


endmodule
