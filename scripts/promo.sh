#!/bin/bash
set -e
 
echo "=============================="
echo " Prometheus Setup Script"
echo "=============================="
 
# Update system
sudo apt update -y
 
# Create a dedicated system user for Prometheus
sudo useradd --system --no-create-home --shell /bin/false prometheus
 
# Download and extract Prometheus
PROM_VERSION="2.47.1"
wget "https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz"
tar -xvf "prometheus-${PROM_VERSION}.linux-amd64.tar.gz"
 
# Set up directories
sudo mkdir -p /data /etc/prometheus
cd "prometheus-${PROM_VERSION}.linux-amd64/"
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/
 
cd ..
rm -rf "prometheus-${PROM_VERSION}.linux-amd64.tar.gz" "prometheus-${PROM_VERSION}.linux-amd64"
prometheus --version



# Create / update the systemd service (tee just overwrites, safe to re-run)
sudo tee /etc/systemd/system/prometheus.service > /dev/null <<'EOF'
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target
EOF

# Enable and (re)start Prometheus — restart so a re-run picks up any service-file changes
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl restart prometheus
sudo systemctl status prometheus --no-pager

echo "=============================="
echo " Prometheus started successfully"
echo " URL:  http://<SERVER-IP>:9090"
echo " Logs: journalctl -u prometheus -f --no-pager"
echo "=============================="
