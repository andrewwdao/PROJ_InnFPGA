#!/bin/bash

set -eu -o pipefail # fail on error , debug all lines

if [ 'root' != $( whoami ) ] ; then
	echo "Please run as root! (sudo ${0})"
exit 1;
fi

# Origin
# Copyright (C) 2021 Intel Corporation 
# Licensed under the MIT license. See LICENSE file in the project root for
# full license information

# Summary of compile&build commands 

# Generate Qsys RTL files and .sopcinfo file
qsys-generate -syn top_qsys.qsys

# Build NiosII software and mem_init hex file
rm nios2/RFS_SENSOR_bsp/*.mk nios2/RFS_SENSOR_bsp/*.bsp
cd nios2/RFS_SENSOR
if [ -f Makefile ]; then
  rm Makefile
fi
./create-this-app
make mem_init_generate
  
# Compile FPGA design
cd ../..
quartus_sh --flow compile ap064


# Generate RBF file
cd output_files
quartus_cpf -c -o bitstream_compression=on ap064.sof ap064.rbf


cd ..
