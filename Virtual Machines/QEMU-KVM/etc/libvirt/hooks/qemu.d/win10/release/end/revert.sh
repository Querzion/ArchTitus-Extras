### Path >> /etc/libvirt/hooks/qemu.d/win10/release/end/revert.sh
#!/bin/bash
### Debugging
set -x

### Load variables
source "/etc/libvirt/hooks/kvm.conf"

### unload vfio-pci
modprobe -r vfio_pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

### Re-Bind GPU to Driver
virsh nodedev-reattach $VIRSH_GPU_VIDEO
virsh nodedev-reattach $VIRSH_GPU_AUDIO

### Rebind VT consoles	-	ls /sys/class/vtconsole/
echo 1 > /sys/class/vtconsole/vtcon0/bind
# Some machines might have more than 1 virtual console. Add a line for each corresponding VTConsole
echo 0 > /sys/class/vtconsole/vtcon1/bind

### Read nVidia x-config
# nvidia-xconfig --query-gpu-info > /dev/null 2>&1

### Bind EFI-framebuffer
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

### Reload nvidia modules
# modprobe nvidia_drm
# modprobe nvidia_modeset
# modprobe drm_kms_helper
# modprobe nvidia
# modprobe drm
# modprobe nvidia_uvm

###ÂReload AMD modules
modprode amdgpu
# modprode snd_hda_intel

### Restart Display Manager
systemctl start sddm.service	# Manjaro / Arch / ArchTitus
# systemctl start display-manager.service
