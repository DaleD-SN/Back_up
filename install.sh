#!/bin/bash
# Command Run Sheet... not automated/scripted yet.... 

sudo raspi-config nonint do_memory_split 4 
sudo raspi-config nonint do_i2c 0
sudo apt update
sudo apt upgrade -y
sudo mkdir /home/makefarm
sudo chmod ugo+rwx /home/makefarm
sudo apt install build-essential python3-pip python3-venv git curl wget screen net-tools openscad fonts-liberation fonts-liberation2 -y
sudo curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash - 
sudo apt-get install -y nodejs
sudo npm install -g pm2
sudo pip3 install Adafruit_GPIO  Adafruit_SSD1306
wget https://raw.githubusercontent.com/ServiceNowEvents/HZ-MakeFarm-Scripts/main/CNC/code/cnc_scripts/statusmon.py?token=GHSAT0AAAAAACILBFKH4XRFZKVUMWZRFYNKZI27TRA
mv statusmon.py* statusmon.py
pm2 start "/home/makefarm/statusmon.py"
pm2 save
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u makefarm --hp /home/makefarm
python -m venv OctoPrint
OctoPrint/bin/pip install OctoPrint==1.8.7
source ./OctoPrint/bin/activate
mkdir ~/plugins/
cd ~/plugins/
wget https://github.com/synman/Octoprint-Bettergrblsupport/archive/refs/tags/2.2.1.zip -O Better-Grbl-Support-2.2.1.zip
wget https://github.com/OctoPrint/OctoPrint-Slic3r/archive/refs/tags/1.3.0.zip -O slic3r.1.3.0.zip
wget https://github.com/OctoPrint/OctoPrint-FileCheck/archive/refs/tags/2021.2.23.zip -O filecheck.2021.2.23.zip
wget https://github.com/OctoPrint/OctoPrint-FirmwareCheck/archive/refs/tags/2021.10.11.zip -O firmwarecheck-2021.10.11.zip
wget https://github.com/jneilliii/OctoPrint-ipOnConnect/archive/refs/tags/0.2.4.zip -O iponconnect.0.2.4.zip
wget https://github.com/kantlivelong/OctoPrint-SmartPreheat/archive/refs/tags/0.0.6.zip -O smartpreheat.0.0.6.zip
wget https://github.com/2blane/OctoPrint-Webhooks/archive/refs/tags/3.0.3.zip -O webhooks.3.0.3.zip
/home/makefarm/OctoPrint/bin/python -m pip --disable-pip-version-check install file:///home/makefarm/plugins/Better-Grbl-Support-2.2.1.zip  --no-cache-dir
/home/makefarm/OctoPrint/bin/python -m pip --disable-pip-version-check install file:///home/makefarm/plugins/slic3r.1.3.0.zip  --no-cache-dir
/home/makefarm/OctoPrint/bin/python -m pip --disable-pip-version-check install file:///home/makefarm/plugins/filecheck.2021.2.23.zip  --no-cache-dir
/home/makefarm/OctoPrint/bin/python -m pip --disable-pip-version-check install file:///home/makefarm/plugins/firmwarecheck-2021.10.11.zip  --no-cache-dir
/home/makefarm/OctoPrint/bin/python -m pip --disable-pip-version-check install file:///home/makefarm/plugins/iponconnect.0.2.4.zip  --no-cache-dir
/home/makefarm/OctoPrint/bin/python -m pip --disable-pip-version-check install file:///home/makefarm/plugins/smartpreheat.0.0.6.zip  --no-cache-dir
/home/makefarm/OctoPrint/bin/python -m pip --disable-pip-version-check install file:///home/makefarm/plugins/webhooks.3.0.3.zip  --no-cache-dir
cd ~ ; rm -rf ~/plugins/
deactivate
pm2 start "/home/makefarm/OctoPrint/bin/octoprint serve"
pm2 save
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u makefarm --hp /home/makefarm
sudo apt install openjdk-11-jre-headless openjdk-11-jdk-headless -y
wget https://install.service-now.com/glide/distribution/builds/package/app-signed/mid/2023/06/23/mid.utah-12-21-2022__patch4-hotfix2-06-23-2023_06-23-2023_2224.linux.x86-64.zip
mkdir ~/mid/ ; cd ~/mid/ ; unzip ../mid.utah-12-21-2022__patch4-hotfix2-06-23-2023_06-23-2023_2224.linux.x86-64.zip 
sed -i 's/#wrapper.java.command=jre\/bin\/java/wrapper.java.command=\/usr\/bin\/java/' /home/makefarm/mid/agent/conf/wrapper-override.conf
cd ~/mid/agent; sudo ./installer.sh -silent -INSTANCE_URL https://securecreator.servicenowcloud.com.au/ -MUTUAL_AUTH N -MID_USERNAME mid_au-cnc-01 -MID_PASSWORD dmqXCyZGA2NVJmkQWBZhn4YFN3TS5crz. -USE_PROXY N -APP_NAME aucnc01 -MID_NAME au-cnc-01 -APP_LONG_NAME au-cnc-01 -CERTIFICATE_REVOCATION N -NON_ROOT_USER makefarm
rm ~/mid.utah-12-21-2022__patch4-hotfix2-06-23-2023_06-23-2023_2224.linux.x86-64.zip
cd ~
mkdir -p ~/.local/share/OpenSCAD/libraries/ ; cd ~/.local/share/OpenSCAD/libraries/
wget https://tv-zip.thingiverse.com/zip/3004457 -O Measuring_and_wrapping_text_in_OpenSCAD_3004457.zip
unzip -j Measuring_and_wrapping_text_in_OpenSCAD_3004457.zip 
cd ~ ; wget https://sh.rustup.rs -O rush.sh ; sh rush.sh -y ; rm rush.sh
source "$HOME/.cargo/env"
cd ~ ; wget https://github.com/sameer/svg2gcode/archive/refs/tags/v0.0.7.zip
unzip v0.0.7.zip ; rm v0.0.7.zip ; mv svg2gcode-0.0.7 svg2gcode ; cd ~/svg2gcode ; cargo add svg2gcode
wget https://raw.githubusercontent.com/ServiceNowEvents/HZ-MakeFarm-Scripts/main/CNC/code/cli_name_generator/svg2gcode_settings.json?token=GHSAT0AAAAAACILBFKHC7QE3N2IWZZ3UFRIZI27MXQ -O ~/svg2gcode/svg2gcode_settings.json
wget https://raw.githubusercontent.com/ServiceNowEvents/HZ-MakeFarm-Scripts/main/CNC/code/cli_name_generator/engravebrick.scad?token=GHSAT0AAAAAACILBFKH737NAKLB72SYAD2UZI27JIQ -O ~/engravebrick.scad
wget https://raw.githubusercontent.com/ServiceNowEvents/HZ-MakeFarm-Scripts/main/CNC/code/cli_name_generator/mkname.sh?token=GHSAT0AAAAAACILBFKHUEAC4MIVMR6HXKE4ZI263YA -O ~/mkname.sh
sed -i 's/OUTPUT=\/home\/pi\/out.gcode/OUTPUT=\/home\/makefarm\/out.gcode/' /home/makefarm/mkname.sh
chmod +x mkname.sh ; ~/mkname.sh


# Things I have not scripted yet!
#
# you need to add the mid server cleanup script!!!!

    makefarm@au-cnc-01:~/mid $ cat cleanup.sh
        #!/bin/sh
        rm -f /home/makefarm/mid/agent/*DH*
    makefarm@au-cnc-01:~/mid $ cat agent/bin/mid.sh|grep cleanup.sh
    FILES_TO_SOURCE="/home/makefarm/mid/cleanup.sh"



#reverse proxy octoprint...

apt install nginx

# "nginx config file" - /etc/nginx/nginx.conf
# just a reverse proxy so port 80 works for the spoke... I was too lazy to find the option in makefarm
# --------------------------
user www-data;
worker_processes 1;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;


    events {
        worker_connections  1024;
    }

    http {
        include            mime.types;
        default_type       application/octet-stream;
        sendfile           on;
        keepalive_timeout  65;

        map $http_upgrade $connection_upgrade {
            default upgrade;
            '' close;
        }

        upstream "octoprint" {
            server 127.0.0.1:5000;
        }

        upstream "mjpg-streamer" {
            server 127.0.0.1:8080;
        }

        server {
            listen       80;
            server_name  localhost;

            location / {
                proxy_pass http://octoprint/;
                proxy_set_header Host $http_host;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Scheme $scheme;
                proxy_http_version 1.1;

                client_max_body_size 0;
            }

            location /webcam/ {
                proxy_pass http://mjpg-streamer/;
            }

            # redirect server error pages to the static page /50x.html
            error_page   500 502 503 504  /50x.html;
            location = /50x.html {
                root   html;
            }
        }
    }
--------------------------------
#
# octoprint webhooks config - the restore from backup will override the plugin versions you installed above and will break the CNC but fix the webhooks... 
# manually add the following replacing the existing and make sure to get the indentation/layour of the YAML correct.

makefarm@au-cnc-01:~ $ grep -A 39 webhooks .octoprint/config.yaml
  webhooks:
    hooks:
    - apiSecret: ''
      content_type: JSON
      data: "{\n  \"deviceIdentifier\":\"@deviceIdentifier\",\n  \"apiSecret\":\"@apiSecret\",\n
        \ \"topic\":\"@topic\",\n  \"message\":\"@message\",\n  \"extra\":\"@extra\",\n
        \ \"state\": \"@state\",\n  \"job\": \"@job\",\n  \"progress\": \"@progress\",\n
        \ \"currentZ\": \"@currentZ\",\n  \"offsets\": \"@offsets\",\n  \"meta\":
        \"@meta\",\n  \"currentTime\": \"@currentTime\"\n}"
      deviceIdentifier: ''
      eventError: true
      eventErrorMessage: There was an error.
      eventPrintDone: true
      eventPrintDoneMessage: Your print is done.
      eventPrintFailed: true
      eventPrintFailedMessage: Something went wrong and your print has failed.
      eventPrintPaused: true
      eventPrintPausedMessage: Your print has paused. You might need to change the
        filament color.
      eventPrintProgressMessage: Your print is @percentCompleteMilestone % complete.
      eventPrintStarted: true
      eventPrintStartedMessage: Your print has started.
      eventUserActionNeeded: true
      eventUserActionNeededMessage: User action needed. You might need to change the
        filament color.
      event_print_progress: false
      event_print_progress_interval: '50'
      headers: "{\n  \"Content-Type\": \"application/json\"\n}"
      http_method: POST
      oauth: false
      oauth_content_type: JSON
      oauth_data: "{\n  \"client_id\":\"myClient\",\n  \"client_secret\":\"mySecret\",\n
        \ \"grant_type\":\"client_credentials\"\n}"
      oauth_headers: "{\n  \"Content-Type\": \"application/json\"\n}"
      oauth_http_method: POST
      oauth_url: ''
      test_event: PrintStarted
      url: https://hub.secure-creator.com.au/api/x_258747_octoprint/octoprint
      webhook_enabled: true
    settings_version: 2
