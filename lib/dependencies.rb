require "bunny"
require "dotenv"
require "net/http"
require "nokogiri"
require "que"
require "uri"
require "useragents"

# Database
require "pg"
require "sequel"
require "bifrost"

require_relative "jobs/check_and_persist_proxy_job"
require_relative "jobs/check_proxies_job"
require_relative "jobs/find_proxies_job"
require_relative "jobs/send_proxies_job"

require_relative "njord/delete_proxies"
require_relative "njord/delete_proxy"
require_relative "njord/fetch"
require_relative "njord/find"
require_relative "njord/load_proxies"
require_relative "njord/parse_last_page_number"
require_relative "njord/parse_proxies"
require_relative "njord/persist_proxy"
require_relative "njord/send_proxies"
require_relative "njord/verify"

require_relative "environment"
Environment.load