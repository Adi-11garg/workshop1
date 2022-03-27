#!/bin/bash

sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
sudo echo -e "Hello World! This is Testing Page of Website. \n\n" >/var/www/html/index.nginx-debian.html
sudo hostname -I | awk '{print $1}' >>/var/www/html/index.nginx-debian.html 
sudo systemctl restart nginx