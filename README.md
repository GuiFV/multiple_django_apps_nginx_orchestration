# Easy multi Django apps on AWS w/ Nginx
#### Designed for usage with https://github.com/GuiFV/django-quickstart
### Requirements

- linux instance deployed on AWS
- docker installed on instance
- registered domains pointed to instance (Public IPv4 address)
- SSL for domains
  - (optional) route domains DNS through Cloudflare for free SSL

### Step 1 - setup
1. access your linux instance
2. copy "Dockerfile" and "conf.d" to main folder (the one you land on when access via ssh, usually '../home/ec2-user')
3. git pull your django apps (on the same folder) respecting the docker-compose.yml notes on the link above

#### Change the following:
- on Dockerfile, change website_1 and website_2 for the names of your apps (this helps with identification)
- under conf.d, change the name of the files to the same as the item above
- under docker-compose.yml change the volumes names directories so the paths are correct, like the item above
- under each .conf file, change the static alias prefix for the names of your apps (they must match the static ones in the docker-compose)
- inside each .conf, change the domain to the respective app domain
- notice that each app will be exposed in a different proxy_pass (in this example, website_1 is on port 8000 and website_2 is on port 8001)
- don't forget to change for the same port on the docker-compose.yml file on the respective application (command:gunicorn and expose:)

### Step 2 - spin up each application and then the nginx
- go to each application folder
  - copy and do the necessary changes on the .env file 
  - spin it up with `docker-compose up -d --build`
  - migrate your database with `docker-compose run web python amanage.py migrate`
  - create a superuser with `docker-compose run web python amanage.py createsuperuser`
  - collect your static files `docker-compose run web python amanage.py collectstatic`
- lastly, go back to main folder (the one with the nginx docker files) and run `docker-compose up -d --build`
- open your browser and visit each app - they should be served correctly 

### Serving more apps on the same server
- replicate .conf paths in the Dockerfile, static alias in the docker-compose and create the respective .conf files for each app
- don't forget to expose each app in a different port
- you can serve as many applications as your instance can handle
