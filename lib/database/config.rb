class Database
  module Config
    def default_config
      return {} if ENV["DATABASE_URL"]
      {
        adapter: "postgres",
        encoding: "utf8",
        host: ENV["DATABASE_HOST"],
        database: ENV["DATABASE_NAME"],
        username: ENV["DATABASE_USER"],
        password: ENV["DATABASE_PASSWORD"],
      }
    end
  end
end
