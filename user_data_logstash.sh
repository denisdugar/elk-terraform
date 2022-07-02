#!/bin/bash
sudo apt update
sudo apt install default-jre -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install logstash -y
sudo echo "input {
  tcp {
    port => 5044
  }
}

output {
  elasticsearch {
    hosts => [\"master0\", \"master1\", \"node0\", \"node1\", \"node2\", \"node3\"]
  }
}" | sudo tee /etc/logstash/conf.d/logstash.conf
sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t
sudo systemctl start logstash && sudo systemctl enable logstash