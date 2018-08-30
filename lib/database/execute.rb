class Database
  module Execute
    def create
      return unless default_config[:database]

      db = connect_to_default_database
      db.execute(
        "CREATE DATABASE #{default_config[:database]} " +
          "ENCODING '#{default_config[:encoding]}';"
      )
    end

    def drop
      return unless default_config[:database]

      db = connect_to_default_database
      db.execute(
        "DROP DATABASE #{default_config[:database]}"
      )
    end
  end
end
