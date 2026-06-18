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

