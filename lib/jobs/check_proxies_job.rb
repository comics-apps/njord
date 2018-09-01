class CheckProxiesJob < Que::Job
  def run
    Njord::LoadProxies.call(:unchecked) do |proxy|
      CheckAndPersistProxyJob.enqueue(proxy[:ip], proxy[:port], proxy[:time])
    end
  end
end
