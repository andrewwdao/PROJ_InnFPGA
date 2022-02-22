# Note for the Implement Environment (De10-nano)
.rbf (fpga binary file) and .dtb (device tree binary file) must be on /lib/firmware

Use scp to move these file to ~/wd/overlay on De10-nano:
- *.dtbo: device tree binary overlay file
- *.rbf: fpga binary firmware file generated from Quartus
- imp-env_stop-FPGA-access: run this once to stop all the connection from HPS to FPGA
- imp-env_apply-overlay: run this once with *.dtbo and *.rbf filename as arguments respectively to apply new fpga firmware (not permanent, reset when restart).

To make the change permanent, either do it using Azure IoT Hub,

or change the overlay device tree blob loaded by the systemd startup service in /lib/firmware/overlay.dtbo (**recommended - remember to backup**)

or change /overlay/fpgaoverlay.sh content

ref in Appendix: https://www.intel.com/content/www/us/en/developer/articles/technical/reconfigure-an-fpga-from-the-cloud-with-containers.html


# Note for the Development Environment (Debian)

This folder supposes to contain:
- *.dtso: device tree source overlay file to generate *.dtbo
- *.rbf: fpga binary firmware file generated from Quartus
- dev-env_dtbo-prepare: prepare the environment to generate *.dtbo file
- dev-env_dtbo-compile: compile the *.dtbo file