# CPU PINNING   -       lscpu -e # Unlock all cores for GNU/Linux

systemctl set-property --runtime -- user.slice AllowedCPUs=0-15u
systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
