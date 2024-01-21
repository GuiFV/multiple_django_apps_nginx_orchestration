# Easy multi Django apps on AWS w/ Nginx
#### Designed for usage with https://github.com/GuiFV/django-quickstart
### Requirements

- linux instance deployed on AWS
- docker installed on instance
- registered domains pointed to instance (Public IPv4 address)
- SSL for domains
  - (optional) route domains DNS through Cloudflare for free SSL

### Step 1
1. access your linux instance
2. copy "Dockerfile" and "conf.d" to main folder (the one you land on when access via ssh, usually '../home/ec2-user')
3. git pull your django apps (on the same folder) respecting the docker-compose.yml notes on the link above

#### Change the following:
- on Dockerfile, change website_1 and website_2 for the names of your apps (this helps with identification)
- under conf.d, change the name of the files to the same as the item above
- inside each .conf, change the domain to the respective app domain
- notice that each app will be exposed in a different proxy_pass (in the default .conf files, 8000 and 8001)
- don't forget to change for the same port on the docker-compose.yml file on the respective application (command:gunicorn and expose:)

### Step 2
- go to each application folder and spin them up with docker-compose 
- go back to main folder and run `docker-compose up -d --build`
- navigate to each app ur - they should be served correctly (don't forget to 'collectstatic' each one)

### Serving more websites
By replicating the .conf calls in the Dockerfile and creating their respective .conf files, you can serve as many applications as your instance can handle
