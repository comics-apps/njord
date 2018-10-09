class SendProxiesJob < Que::Job
  def run(count)
    proxies = Njord::LoadProxies.call(:checked, count: count)

    if proxies.size == count
      Njord::SendProxies.call(proxies)
    else
      SendProxiesJob.enqueue(count, run_at: Time.now + 5, priority: 2)
    end
  end
end
