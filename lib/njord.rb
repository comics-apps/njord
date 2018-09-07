require_relative "dependencies"

config = Bifrost.config(prefix: "DATABASE")
Bifrost.connect(:postgres, config)

Database = Bifrost.postgres
Que.connection = Bifrost.postgres
