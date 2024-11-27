
#!/bin/bash
# Check if the directory already exists
if [ ! -d "/etc/systemd/system/docker.service.d" ]; then
  sudo mkdir -p /etc/systemd/system/docker.service.d
fi

# Write the configuration for the NVIDIA runtime
sudo tee /etc/systemd/system/docker.service.d/override.conf > /dev/null <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host=fd:// --host=unix:///var/run/docker.sock --add-runtime=nvidia=/usr/bin/nvidia-container-runtime
EOF

# Reload systemd to apply changes and restart Docker
sudo systemctl daemon-reload
sudo systemctl restart docker