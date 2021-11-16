# CPU PINNING	-	lscpu -e # Lock linux to only using 1 core & 1 logic core

systemctl set-property --runtime -- user.slice AllowedCPUs=0,8
systemctl set-property --runtime -- system.slice AllowedCPUs=0,8
systemctl set-property --runtime -- init.scope AllowedCPUs=0,8
