#!/bin/bash

C:/intelFPGA_lite/17.1/quartus/bin64/quartus_cpf -c ../Quartus_SoC/soc_system.sof ./soc_system.rbf
#scp ./soc_system.rbf root@129.22.143.88:/media/root/5459-A1D61/soc_system.rbf
#scp ./soc_system.rbf root@dajo-de1soc:/media/root/5459-A1D63/soc_system.rbf
scp ./soc_system.rbf root@192.168.10.187:/media/root/5459-A1D61/soc_system.rbf
