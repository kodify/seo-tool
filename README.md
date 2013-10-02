## Seo-tool

### Requirements

- Ruby >= 1.9.3
- Mysql


### Get seo tools working working

```
git clone git@github.com:kodify/seo-tool.git
cd seo-tool
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
