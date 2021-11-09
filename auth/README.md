# Auth Microservice
Create user and get tokens for them.

Create user:
```POST http://0.0.0.0:3000/v1/signup?name=User_name&email=this@user.email&password=12345678```

Get token:
```POST http://0.0.0.0:3000/v1/login?email=this@user.email&password=12345678```

For auth by token:
```POST http://0.0.0.0:3000/v1/auth Authorization: Bearer <paste_token_here>```

## Setup

Rename file `/config/settings.yml.sample` to `/config/settings.yml` and change on your settings.

```bash
$ bundle

$ createdb -h localhost -U <user_or_exclude_this_flag> auth_microservice_development
$ bin/rake db:migrate

$ createdb -h localhost -U <user_or_exclude_this_flag> auth_microservice_test
$ RACK_ENV=test bin/rake db:migrate

$ bin/puma
```


## Other
IRB console:
```bash
bin/console
```


Tests:
```bash
bin/rspec
```
