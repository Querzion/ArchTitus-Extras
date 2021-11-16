### Path >> /etc/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh
#!/bin/bash
### Debugging
set -x

### Load variables defined in kvm.conf
source "/etc/libvirt/hooks/kvm.conf"

### Stop display manager
systemctl stop sddm.service # Manjaro / Arch / ArchTitus
# systemctl stop display-manager.service 

### Uncomment the following line if you use GDM
#killall gdm-x-session

### Unbind VTconsoles	-	ls /sys/class/vtconsole/
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

### Unbind EFI-Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

### Avoid a Race condition by waiting 5 seconds. This can be calibrated to be shorter or longer if required for your system
sleep 5

### Unload nVidia	- uncomment if nVidia is GPU
# modprobe -r nvidia_drm
# modprobe -r nvidia_modeset
# modprobe -r drm_kms_helper
# modprobe -r nvidia
# modprobe -r i2c_nvidia_gpu
# modprobe -r drm
# modprobe -r nvidia_uvm

### Unload AMD 	- uncomment if AMD is GPU
modprode -r amdgpu
# modprode -r snd_hda_intel

### Unbind the GPU from display driver
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO

### Load VFIO Kernel Module
modprobe vfio
modprobe vfio-pci
modprobe vfio_iommu_type1
