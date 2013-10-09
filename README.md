
## Seo-tool


* To setup using provided VM you'll need to install the latest versions of the following software for your OS
    * Vagrant: http://downloads.vagrantup.com/ (>= 1.1)
    * Virtual Box: https://www.virtualbox.org/wiki/Downloads

* Once you have vagrant installed, fork the project to your GitHub account and clone from there to your machine.

    git clone git@github.com:kodify/seo-tool.git

Using the terminal navigate to the directory where you cloned the project and type:

    vagrant up
    vagrant ssh

### Get seo tools working working

```
cd /var/www/seo-tool/current
```

install all dependencies:
```
bundle install
```

configure your database access on *config/database.yml*
and create it with
```
rake db:create
rake db:migrate
```

you also will need the next environment vars on your machine:
```
OAUTH_ID='google oauth id (the one related with mail)'
OAUTH_SECRET='google oauth secret'
OAUTH_VALID_DOMAIN='kodify.io'
```

now just start the server with:
```
rails s
```

now you can access your application on http://localhost:3000


## Thats it! enjoy it


