class CheckProxiesJob < Que::Job
  def run
    all_proxies = Njord::LoadProxies.call
    if all_proxies.size < ENV.fetch("MIN_PROXY_COUNT", 50).to_i
      FindProxiesJob.enqueue
    end

    proxies = Njord::LoadProxies.call(:checked)
    ids = proxies.map{ |p| p[:id] }
    Database[:proxies].where(id: ids).update(status: "unchecked")

    Njord::LoadProxies.call(:unchecked) do |proxy|
      CheckAndPersistProxyJob.enqueue(proxy[:ip], proxy[:port], proxy[:time])
    end

    CheckProxiesJob.enqueue(run_at: Time.now + 300) # 5 minutes from now
  end
end
