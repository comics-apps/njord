# Njord - Workflow

1. On queue `need_proxies` receive message with number of proxies

1. Run `SendProxies` background job

1. Remove sent proxies from databases

## SendProxies

1. When number of ready proxies is equal send proxies on enqueu `new_proxies`

1. When number of ready proxies if less than required then retry background job after 1 minute deplay

## CheckProxies

CheckProxies if first enqueued at start time and then it is enqueued every 5 minutes

1. When number of total proxies is less then ENV["MIN_PROXY_COUNT"] or 50 (if ENV["MIN_PROXY_COUNT"] doesn't exist) run `FindProxiesJob` background job

1. Mark checked proxies as unchecked

1. Load unchecked proxies from database

1. For each proxy run `CheckAndPersistProxy` background job

## CheckAndPersistProxy

1. When proxy is valid save or update proxy in database

## FindProxies

1. Load proxies from proxy site

1. For each proxy run background job `CheckAndPersistProxy`
