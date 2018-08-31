require "singleton"

require_relative "database/config"
require_relative "database/connection"
require_relative "database/database_url"
require_relative "database/dataset"
require_relative "database/execute"

class Database
  include Singleton

  include Config
  include Connection
  include DatabaseUrl
  include Execute
  extend Dataset
end
