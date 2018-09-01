class CheckAndPersistProxyJob < Que::Job
  def run(ip, port, time)
    return unless Njord::Verify.call(ip, port, time)
    Njord::PersistProxy.call(ip, port, time)
  end
end
