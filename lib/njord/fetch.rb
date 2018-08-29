module Njord
  module Fetch
    PAGE_URL = "http://www.gatherproxy.com/proxylist/anonymity/".freeze
    CONTENT_TYPE = "application/x-www-form-urlencoded".freeze

    def self.call(page)
      proxies = []
      uri = URI.parse(PAGE_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      headers = {
        "Content-Type" => CONTENT_TYPE,
        "User-Agent" => UserAgents.rand
      }

      request = Net::HTTP::Post.new(uri.path, headers)
      request.set_form_data({ "Type" => "elite", "PageIdx" => page, "Uptime" => 0 })

      http.request(request)
    end
  end
end
