# Ads Microservice
GET and POST ads.

For get list of ads:
```GET http://0.0.0.0:3000/ads/v1```

For create new ad:
```POST http://0.0.0.0:3000/ads/v1?ad[title]="Add title"&ad[description]="Add description"&ad[city]="Add city"&user_id=1```

## Setup

Rename file `/config/settings.yml.sample` to `/config/settings.yml` and change on your settings.

```bash
$ bundle

$ createdb -h localhost -U <user_or_exclude_this_flag> ads_microservice_development
$ bin/rake db:migrate

$ createdb -h localhost -U <user_or_exclude_this_flag> ads_microservice_test
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
