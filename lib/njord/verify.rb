module Njord
  module Verify
    def self.call(ip, port, time)
      result = Net::HTTP.new("api.ipify.org", nil, ip, port).start { |http|
        http.get("/")
      }

      ip == result.body
    end
  end
end
