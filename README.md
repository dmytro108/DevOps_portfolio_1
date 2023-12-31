# DevOps portfolio - AWS and Terraform
## The task:
1. Create an AWS EC2 instance with a public IP and restricted access by protocols (ssh, http, https) and certain IP addresses
2. Run a custom Web application utilzing a public API like weather report, currency rates, etc. The web application should work with NGINX and should be accessable by a custom route like *http://<server_addr>/custom_route*
3. Create an AWS user with rights enough to check the infrastructure and update the Security Group for getting access to the Web server
## Solution:
### Infrastructure
The whole AWS infrastructure created with Terraform scripts. See the [terraform](/terraform) folder for the detalies. It creates:
- VPC 
- a public subnet 
- a free tier EC2 instance. The EC2 instance uses ami  RHEL9 and provisioned for using Docker.
- an IAM user d.john with Power user role.

The terraform apply command outputs the user password, server public IP and the Domain name. To connect the EC2 instance via ssh, please, use the private key from secrets folder. Place the id_ed25519 file in your ~/.ssh folder and run:
```
ssh ec2-user@<server_ip>
```
### Web App
The web application utilizes public free [API](http://weatherapi.com) from weatherapi.com. It displays current weather report in some Europian capitals. The applicatin is written in JavaScript and runs in browser. See HTML and JS sources in [src](/src) folder. The NGINX configuration file is placed in [nginx](/nginx) folder. It is a */etc/nginx/config.d/* including config file. Web application is accessable by URL like:
```
http://<server_addr>/weather
```
#### Access to the webserver
Access to the webserver is restricted by IP address. You can either edit [terraform.tfvars](/terraform/terraform.tfvars) setting your IP in varuable **allowed_ip** or update the Security group rooles.
### CI
Simple CI pipeline was built with Jenkins, please see [Jenkinsfile](/Jenkinsfile)  for detailes. It has a simple quality gate which checks if the web app is accesible. If the the gate passed it builds Docker image and pushes it to the Docker Hub registry. See the [Dockerfile](/Dockerfile) for detailes. You can find the image [dmytro108/weatherapp](https://hub.docker.com/r/dmytro108/weatherapp) on the Docker Hub registry. 
### Deployment
Deployment is a manual process. Run Docker container on the webserver:
```
docker run -d -p 80:80 --name weatherapp dmytro108/weatherapp:latest
```
