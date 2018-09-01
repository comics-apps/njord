class FindProxiesJob < Que::Job
  def run
    Njord::Find.call
  end
end
