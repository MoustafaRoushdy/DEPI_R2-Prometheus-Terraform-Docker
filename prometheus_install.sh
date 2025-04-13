#!/bin/bash
sudo docker run -d -v /home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml -p 9090:9090 --name prometheus prom/prometheus