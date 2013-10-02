## Seo-tool


* To setup using provided VM you'll need to install the latest versions of the following software for your OS
    * Vagrant: http://downloads.vagrantup.com/
    * Virtual Box: https://www.virtualbox.org/wiki/Downloads

* Once you have vagrant installed, fork the project to your GitHub account and clone from there to your machine.

    git clone git@github.com:kodify/seo-tool.git

Using the terminal navigate to the directory where you cloned the project and type:

    vagrant up

### Get seo tools working working

```
cd seo-tool
```

** linux users also will need this:
```
sudo apt-get install libmysql-ruby libmysqlclient-dev
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

now just start the server with:
```
rails s
```

now you can access your application on http://localhost:3000


## Thats it! enjoy it


