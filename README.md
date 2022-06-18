# UNEPO-Stack-On-EC2-with-AWS-SDK-JS

<br>
<strong>
Deploys Ubuntu, NodeJS, ExpressJS and PostgreSQL (UNEPO) Stack on AWS EC2 with AWS SDK for JavaScript/NodeJS V2.
</strong>
<br><br>
The  Script deploys the following specific resources and software:

1) AWS EC2 instance(s) with Ubuntu 22.04 LTS OS
                                                                                                                                                 
2) Bash launch or start-up script (user data) for the installation of software, on the instance(s), including:

   -  Additional Ubuntu OS Packages <br>
   -  NodeJS <br>
   -  ExpressJS Web Server Framework <br>
   -  Other Node.js Packages and <br>
   -  PostgreSQL


## DEPLOYING STACK with the NodeJS script

### To deploy the stack  on ```AWS```, follow these steps:

1) #### Install NodeJS
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - <br>
    sudo apt-get install -y nodejs
    
2) #### Download or clone the following files, from this repo, into the current working directory (CWD): <br>
   NodeJS script - index.js <br>
   User data bash script (launch script)  - user-data.sh <br>
   JSON files  - credentials.json and inputConfig.json <br>

3) #### Fill in relevant values in the <b>credentials.json</b> and in the <b>inputConfig.json</b> <br>

4) #### Then run code, assuming sudo access: <br>
   sudo node index.js


# License

Copyright © 2015 - present. MongoExpUser