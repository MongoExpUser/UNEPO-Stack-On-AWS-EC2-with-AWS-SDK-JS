#.............................................................................................................#
#                                                                                                             #
#  @License Starts                                                                                            #
#                                                                                                             #
#  Copyright © 2015 - present. MongoExpUser.  All Rights Reserved.                                            #
#                                                                                                             #
#  License: MIT- https://github.com/MongoExpUser/UNEPO-Stack-On-EC2-with-AWS-SDK-JS/blob/main/LICENSE         #
#                                                                                                             #
#  @License Ends                                                                                              #
#                                                                                                             #
#.............................................................................................................#
#  user-data.sh (lauch/start-up script) - performs the following actions:                                     #
#  1) Installs additional Ubuntu packages                                                                     #
#  2) Installs and configures Node.js v18.x and Express v5.0.0-alpha.8 web server framework                   #
#     Installs other node.js packages                                                                         #
#  3) Installs postgresql server                                                                              #
#.............................................................................................................#



#!/bin/bash

# a. set permssion and create directories
sudo chmod 777 /home/ubuntu
cd /home
sudo mkdir base
cd base
sudo mkdir server
sudo mkdir client

# b. install  packages/libraries/programs
# 0. update and upgrade system
sudo apt-get -y update
echo -e "Y"
echo -e "Y"
echo -e "Y"

sudo apt-get -y upgrade
echo -e "Y"
echo -e "Y"
echo -e "Y"

sudo apt-get -y dist-upgrade
echo -e "Y"
echo -e "Y"
echo -e "Y"

# 1. general
sudo apt-get install -y systemd procps nano apt-utils wget curl gnupg2 make sshpass cmdtest spamassassin snap nmap net-tools aptitude build-essential gcc snapd screen spamc parted iputils-ping certbot python3-certbot-apache unzip
echo -e "Y"
echo -e "Y"
echo -e "Y"

# 2. aws cli (version 2)
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
echo -e "Y"
echo -e "Y"
echo -e "Y"
sudo chmod 777 awscliv2.zip
sudo unzip awscliv2.zip
echo -e "Y"
echo -e "Y"
echo -e "Y"
sudo ./aws/install

# 3. python 3.10
sudo apt-get -y install python3.10
echo -e "Y"
echo -e "Y"
echo -e "Y"

#  4. python3-pip
sudo apt-get -y install python3-pip
echo -e "Y"
echo -e "Y"
echo -e "Y"

#  5. boto3
sudo python3 -m pip install boto3
echo -e "Y"
echo -e "Y"
echo -e "Y"

#  6. awscli & upgrade awscli (version 1)
sudo apt-get -y install awscli
echo -e "Y"
echo -e "Y"
echo -e "Y"
sudo python3 -m pip install --upgrade awscli
echo -e "Y"
echo -e "Y"
echo -e "Y"
    
#  7. node.js version 18x
sudo curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
echo -e "Y"
echo -e "Y"
echo -e "Y"
sudo apt-get install -y nodejs
echo -e "Y"
echo -e "Y"
echo -e "Y"
  
# 8. node.js packages (express server and other packages)
cd '/home/base'
sudo echo ' {
      "name": "Nodejs-Expressjs",
      "version": "1.0",
      "description": "A web server, based on the Node.js-Express.js (NE) stack",
      "license": "MIT",
      "main": "./app.js",
      "email": "info@domain.com",
      "author": "Copyright © 2015 - present. MongoExpUser.  All Rights Reserved.",
      "dependencies"    :
      {
        "express"       : "*"
      },
      "devDependencies": {},
      "keywords": [
        "Node.js",
        "Express.js",
        "PostgreSQL\""
      ]
    }' > package.json
# a. all modules (except aws modules)
sudo npm install express@5.0.0-alpha.8
sudo npm install -g npm
sudo npm install bcryptjs
sudo npm install bcrypt-nodejs
sudo npm install bindings
sudo npm install bluebird
sudo npm install body-parser
sudo npm install command-exists
sudo npm install compression
sudo npm install connect-flash
sudo npm install cookie-parser
sudo npm install express-session
sudo npm install formidable
sudo npm install html-minifier
sudo npm install level
sudo npm install memored
sudo npm install mime
sudo npm install mkdirp
sudo npm install ocsp
sudo npm install pg
sudo npm install python-shell
sudo npm install s3-proxy
sudo npm install s3-node-client
sudo npm install serve-favicon
sudo npm install serve-index
sudo npm install uglify-js2
sudo npm install uglify-js@2.2.0
sudo npm install uglifycss
sudo npm install uuid
sudo npm install vhost
sudo npm install @faker-js/faker
sudo npm install mongodb
sudo npm install namesilo-domain-api
sudo npm install xml2js
# b. all modules of aws sdk for javaScript/node.sj v2
sudo npm install aws-sdk
# c. selected modules of aws sdk for javascript/node.sj v3
sudo npm install @aws-sdk/client-apigatewayv2
sudo npm install @aws-sdk/client-comprehend
sudo npm install @aws-sdk/client-comprehendmedical
sudo npm install @aws-sdk/client-efs
sudo npm install @aws-sdk/client-elasticache
sudo npm install @aws-sdk/client-elasticsearch-service
sudo npm install @aws-sdk/client-firehose
sudo npm install @aws-sdk/client-lambda
sudo npm install @aws-sdk/client-lex-model-building-service
sudo npm install @aws-sdk/client-lex-models-v2
sudo npm install @aws-sdk/client-lex-runtime-service
sudo npm install @aws-sdk/client-lex-runtime-v2
sudo npm install @aws-sdk/client-mq
sudo npm install @aws-sdk/client-mwaa
sudo npm install @aws-sdk/client-neptune
sudo npm install @aws-sdk/client-opensearch
sudo npm install @aws-sdk/client-polly
sudo npm install @aws-sdk/client-redshift
sudo npm install @aws-sdk/client-redshift-data
sudo npm install @aws-sdk/client-redshiftserverless
sudo npm install @aws-sdk/client-rekognition
sudo npm install @aws-sdk/client-rds
sudo npm install @aws-sdk/client-rds-data
sudo npm install @aws-sdk/client-s3
sudo npm install @aws-sdk/client-sns
sudo npm install @aws-sdk/client-timestream-query
sudo npm install @aws-sdk/client-timestream-write
sudo npm install @aws-sdk/client-transcribe
sudo npm install @aws-sdk/client-transcribe-streaming
sudo npm install @aws-sdk/client-translate

#  9. postgres servers and client (latest version)
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
echo -e "Y"
echo -e "Y"
echo -e "Y"
sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo -e "Y"
echo -e "Y"
echo -e "Y"
sudo apt-get update -y
echo -e "Y"
echo -e "Y"
echo -e "Y"
sudo apt-get -y install postgresql
echo -e "Y"
echo -e "Y"
echo -e "Y"

# 10. clean-up
sudo rm -rf /var/lib/apt/lists/*
echo -e "Y"
echo -e "Y"
echo -e "Y"
sudo apt-get autoclean
echo -e "Y"
echo -e "Y"
echo -e "Y"
sudo apt-get autoremove
echo -e "Y"
echo -e "Y"
echo -e "Y"
