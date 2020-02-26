# Statping Dashboard

https://github.com/hunterlong/statping

Status Page for monitoring your websites and applications with beautiful graphs, analytics, and plugins. Run on any type of environment. 
Demo : https://demo.statping.com

## Local environment in Docker

```bash
docker-compose up
```

- Go to : http://localhost:8080
- At the bottom of the page, click on `Dashboard` link (or got to http://localhost:8080/dashboard page)
- Login with `admin` user (default password is `admin`)
- You can then configure Services, Users, Messages and see Logs
- In `Settings`, you can also do a `Bulk Import Services` from a CSV file (you can use `bulk_import.csv` in this folder)

## Troubleshooting

### Bulk import error

Versions earlier than v0.80.65 worked because the configs still had 16 columns of data per service. This changed in the latest build when verify_ssl was added. 
Here are the headers expected now :

```csv
name,domain,expected,expected_status,check_interval,check_type,method,post_data,port,timeout,order_id,allow_notifications,public,group_id,headers,permalink,verify_ssl
```