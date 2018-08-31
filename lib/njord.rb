require "dotenv"
require "net/http"
require "nokogiri"
require "pg"
require "que"
require "sequel"
require "uri"
require "useragents"

require_relative "database"
require_relative "environment"

require_relative "jobs/check_ip_job"

require_relative "njord/fetch"
require_relative "njord/find"
require_relative "njord/parse_last_page_number"
require_relative "njord/parse_proxies"

Environment.load
Que.connection = Database.instance.connection
