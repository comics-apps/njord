# Njord - Workflow

1. On queue `need_proxies` receive message with number of proxies

1. Remove used proxies from database

1. Mark unused proxies to recheck and run `CheckProxies` background job

1. When number of proxies if lesser than required run `FindProxies` background job

1. Run `SendProxies` background job

## CheckProxies

1. Load unused proxies from database

1. For each proxy run background job `CheckAndPersistProxy`

## CheckAndPersistProxy

1. When proxy is valid save or update proxy in database

## FindProxies

1. Load proxies from proxy site

1. For each proxy run background job `CheckAndPersistProxy`

## SendProxies

1. When number of ready proxies is equal send proxies on enqueu `new_proxies`

1. When number of ready proxies if less than required then retry background job after 1 minute deplay
