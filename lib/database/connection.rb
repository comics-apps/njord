class Database
  module Connection
    def connection(database_url = nil)
      database_url ||= build_database_url
      @connection ||= Sequel.connect(database_url)
    end

    def connect_to_default_database
      return unless default_config[:database]
      
      config = default_config.merge(database: "postgres")
      db_url = build_database_url(config)
      connection(db_url)
    end
  end
end
