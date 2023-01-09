#!/bin/bash -e

EMAIL=ishi@toma.tech
HOSTNAME=zulip.toma.tech

BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "USING THE FOLLOWING VARIABLES:"
printf "\n"
printf "EMAIL: ${GREEN}$EMAIL${NC}\n"
printf "HOSTNAME: ${GREEN}$HOSTNAME${NC}\n"
printf "\n"
echo "Continue? (y/n)"
read -r continue
if [ "$continue" != "Y" || "$continue" != "y" ]; then
  echo "Exiting."
  exit;
fi

sudo apt-get update --allow-releaseinfo-change
sudo apt-get install -y build-essential cmake apt-transport-https ca-certificates curl gnupg2 \
  software-properties-common dirmngr unzip git expect jq lsb-release ufw cryptsetup xfsprogs \
  libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev \
  libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev fail2ban

wget -c https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tar.xz
tar -Jxvf Python-3.10.0.tar.xz
cd Python-3.10.0
./configure --enable-optimizations
sudo make altinstall
sudo update-alternatives --install /usr/bin/python python /usr/local/bin/python3.10 1
sudo update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.10 1

# Install docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo groupadd -f docker
sudo usermod -aG docker $(whoami)
sudo chgrp docker /usr/bin/docker 
sudo chgrp docker /usr/bin/docker-compose
echo "[*] Installed dependencies!"

cd $(mktemp -d)
curl -fLO https://download.zulip.com/server/zulip-server-latest.tar.gz
tar -xf zulip-server-latest.tar.gz

sudo bash zulip-server-*/scripts/setup/install --certbot --email=$EMAIL --hostname=$HOSTNAME
