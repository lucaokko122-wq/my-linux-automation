#!/bin/bash 

set -e # exit on any error
set -x


#Configurations
SERVER_IP="10.0.2.15"
SERVER_USER="luka-admin"
REPO_URL="https://github.com/lucaokko122-wq/my-linux-automation.git"
DEPLOY_PATH="/home/$SERVER_USER/my-linux-automation"

echo "starting complete server setting up..."

#Install essentiall packages
echo "Install packages"
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "
	sudo apt update
	sudo apt install -y git python3 python3-pip python3-venv nodejs npm nginx
	"

#clone repo
echo "cloning repo..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "
	if [ -d '$DEPLOY_PATH' ]; then
		cd '$DEPLOY_PATH' && git pull
	else
		git clone '$REPO_URL' '$DEPLOY_PATH'
	fi
	"

#3 Node.js setup
echo "setting Node.js setup..."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "
	if [ -f '$DEPLOY_PATH/package.json' ]; then
		cd '$DEPLOY_PATH'
		npm install
	fi
	"

#Python setup
echo "setting up python...."
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "
	if [ -f $DEPLOY_PATH/requirements.txt]; then
		cd '$DEPLOY_PATH'
		python3 -m venv venv
	./venv/bin/pip install -r requirements.txt
	fi
"

#Create service
echo "creating service"

#Node.js service
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "
	if [ -f '$DEPLOY_PATH/package.json' ]; then
		sudo tee /etc/systemd/system/node-app.service > /dev/null << EOF
		[Unit]
		Description=Node.js App
		After=network.target
		[Service]
		User=$SERVER_USER
		WorkingDirectory=$DEPLOY_PATH
		ExecStart=$DEPLOY_PATH/venv/bin/python app.py
		Restart=always

		[Install]
		WantedBy=multi-user.target
		EOF

		"
#Nginx setup
echo "setting up Nginx"
ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "
	sudo tee /etc/nginx/sites-available/my-app > /dev/null << EOF
	
	server {
		listen 80;
		server_name $SERVER_IP;

		location / {
			proxy_pass http://localhost:3000;
			proxy_set_header Host \\$host;
			proxy_set_header X-Real-IP \\$remote_addr;
		}
	}
EOF

	sudo ln -sf /etc/nginx/sites-available/my-app /etc/nginx/sites-available
	sudo nginx -t && sudo systemctl reload nginx
"

#Start Service

ssh -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP "
	systemctl daemon-reload

	if [ -f '/etc/systemd/system/node-app.service' ]; then 
		sudo systemctl enable node-app.service
		sudo systemctl start node-app.service
	fi

	if [ -f /etc//systemd/system/python-app.service' ]; then
		sudo systemctl enable python-app.service
		sudo systemctl start python-app.service
	fi
"

echo "setup completed"
echo "your app is available at: http://$SERVER_IP"
