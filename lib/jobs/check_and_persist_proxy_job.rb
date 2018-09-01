class CheckAndPersistProxyJob < Que::Job
  def run(ip, port, time)
    if Njord::Verify.call(ip, port, time)
      Njord::PersistProxy.call(ip, port, time)
    else
      Njord::DeleteProxy.call(ip, port)
    end
  rescue => e
    puts e
    Njord::DeleteProxy.call(ip, port)
  end
end
