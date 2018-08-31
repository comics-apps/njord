class CheckIpJob < Que::Job
  def run(ip, port)
    result = Net::HTTP.new("api.ipify.org", nil, ip, port).start { |http|
      http.get("/")
    }

    return unless ip == result.body

    Database[:proxies].insert({ ip: ip, port: port })
  end
end
