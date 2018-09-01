module Njord
  module DeleteProxies
    def self.call(**options)
      Database[:proxies].delete
    end
  end
end
