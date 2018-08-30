class Database
  module DatabaseUrl
    def build_database_url(config = nil)
      return ENV["DATABASE_URL"] if ENV["DATABASE_URL"]

      config ||= default_config
      database_url = "#{config[:adapter]}://"
      if config[:username]
        database_url += "#{config[:username]}:#{config[:password]}@"
      end
      "#{database_url}#{config[:host]}/#{config[:database]}"
    end
  end
end
