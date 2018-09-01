class SendProxiesJob < Que::Job
  def run(count)
    proxies = Njord::LoadProxies.call(:checked, count: count)

    if proxies.size == count
      Njord::SendProxies.call(proxies)
    else
      SendProxiesJob.enqueue(count, run_at: Time.now.to_i + 60)
    end
  end
end
