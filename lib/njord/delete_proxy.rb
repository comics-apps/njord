module Njord
  module DeleteProxy
    def self.call(ip, port)
      Database[:proxies].where(ip: ip, port: port).delete
    end
  end
end
