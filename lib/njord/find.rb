module Njord
  module Find
    def self.call
      proxies = []
      response = Fetch.call(1)
      last_page = ParseLastPageNumber.call(response.body)

      (1..last_page).each do |page|
        response = Fetch.call(page)
        proxies += ParseProxies.call(response.body)
      end

      proxies
    end
  end
end
