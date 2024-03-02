sudo apt-get update -y
sudo apt-get install openjdk-8-jdk -y
sudo useradd -M -d /opt/nexus -s /bin/bash -r nexus
sudo mkdir /opt/nexus
sudo wget -O /opt/nexus/nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar xzf /opt/nexus/nexus.tar.gz -C /opt/nexus --strip-components=1
sudo chown -R nexus:nexus /opt/nexus
sudo tee /etc/systemd/system/nexus.service > /dev/null << EOL
[Unit]
Description=Nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL
sudo systemctl enable nexus
sudo systemctl start nexus
sudo systemctl status nexus
