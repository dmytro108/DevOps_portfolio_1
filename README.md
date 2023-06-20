# Test assignment for DevOps trainee position in Oversecure
## The task:
1. Create an AWS EC2 instance with a public IP and restricted access by protocols (ssh, http, https) and certain IP addresses
2. Run a custom Web application utilzing a public API like weather report, currency rates, etc. The web application should work with NGINX and should be accessable by a custom route like *http://<server_addr>/custom_route*
3. Create an AWS EC2 user with rights enough to check the assignment and update the Security Group for getting access to the Web server
## Solution:
### Infrastructure
The whole AWS infrastructure created with Terraform scripts. See the [terraform](/terraform) folder for the detalies. It creates VPC and a publick subnet with a free tier EC2 instance provisioned with RHEL9 ami Docker. As well it creates user *d.john* with Power user role.
### Web App
The web application utilizes publick free [API](http://weatherapi.com) from weatherapi.com. It displays current weather report in some Europian capitals. The applicatin is written in JavaScript and runs in browser. See HTML and JS dources in [src](/src) folder. The NGINX configuration file is placed in [nginx](/nginx) folder. It is a */etc/nginx/config.d/* including config file.
#### CI
The Web app is built as Docker image. See the [Dockerfile](/Dockerfile) for detailes. You can find the image [dmytro108/weatherapp](https://hub.docker.com/r/dmytro108/weatherapp) on the Docker Hub registry. 
#### Deployment
Deployment is a manual process. Run Docker container on the webserver:

`docker run -d -p 80:80 --name weatherapp dmytro108/weatherapp:latest`
