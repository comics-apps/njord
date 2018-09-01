module Njord
  module DeleteProxies
    def self.call(**options)
      Database[:proxies].where(options).delete
    end
  end
end
