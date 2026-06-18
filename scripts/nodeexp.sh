set -e
 
echo "=============================="
echo " Node Exporter Setup Script"
echo "=============================="
 
# Create a dedicated system user for Node Exporter
sudo useradd --system --no-create-home --shell /bin/false node_exporter
 
# Download and install Node Exporter
NODE_EXPORTER_VERSION="1.6.1"
wget "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
tar -xvf "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
sudo mv "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter" /usr/local/bin/
rm -rf node_exporter*
 
node_exporter --version



# Create / update the systemd service (tee just overwrites, safe to re-run)
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<'EOF'
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter \
    --collector.logind

[Install]
WantedBy=multi-user.target
EOF

# Enable and (re)start Node Exporter — restart so a re-run picks up any service-file changes
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl restart node_exporter
sudo systemctl status node_exporter --no-pager

echo "=============================="
echo " Node Exporter started successfully"
echo " URL:  http://<SERVER-IP>:9100"
echo " Logs: journalctl -u node_exporter -f --no-pager"
echo "=============================="
