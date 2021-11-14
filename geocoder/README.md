# Geocoder Microservice
Returns latitude and longitude for city.

```
GET http://0.0.0.0:3000/geocoder/v1?geocoder[city]=Москва
```

## Setup

```bash
$ bundle

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
