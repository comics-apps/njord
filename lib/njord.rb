require "dotenv"
require "net/http"
require "oga"
require "uri"
require "useragents"

require_relative "environment"

require_relative "njord/fetch"
require_relative "njord/find"
require_relative "njord/parse_last_page_number"
require_relative "njord/parse_proxies"
