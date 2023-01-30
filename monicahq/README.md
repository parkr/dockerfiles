## monicahq

MonicaHQ.com is an open source personal CRM. 

This docker image takes their official one and:

1. moves the apache config to serve at port 8080 instead of 80
2. adds an hourly cron to schedule reminders, etc
