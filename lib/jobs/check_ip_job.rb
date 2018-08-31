class CheckIpJob < Que::Job
  def run(ip, port, time)
    result = Net::HTTP.new("api.ipify.org", nil, ip, port).start { |http|
      http.get("/")
    }

    return unless ip == result.body

    if proxy_id = find_proxy(ip, port)
      update_proxy(proxy_id, time)
    else
      create_proxy(ip, port, time)
    end
  end

  private

  def find_proxy(ip, port)
    proxy = Database[:proxies].where(ip: ip, port: port).first
    proxy ? proxy[:id] : nil
  end

  def update(proxy_id, time)
    Database[:proxies].where(id: proxy_id).update(time: time)
  end

  def create_proxy(ip, port, time)
    Database[:proxies].insert({ ip: ip, port: port, time: time })
  end
end
