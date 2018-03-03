docker-ebot
================

[![](https://images.microbadger.com/badges/version/hsfactory/ebot.svg)](https://microbadger.com/images/hsfactory/ebot "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/hsfactory/ebot.svg)](https://microbadger.com/images/hsfactory/ebot "Get your own image badge on microbadger.com") 

Dockerised eBot (https://github.com/deStrO/eBot-CSGO) for ease of use. 

Pre-Requisites
--------------
* Edit EXTERNAL_IP and EBOT_IP in the docker-compose.yml
* An host **without** mysql, if you use your own mysql, delete the mysql container in the docker-compose.yml

Settings
---------
Edit the following settings in [docker-compose.yml](docker-compose.yml) to your needs.

Run
---
`docker-compose up -d`

Quick start
-----------
* Connect to the running eBot web interface @ `http://$hostip/`

* To admin goto `http://$hostip/admin.php` - u:admin p:password
