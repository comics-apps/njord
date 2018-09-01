module Njord
  module PersistProxy
    def self.call(ip, port, time)
      if proxy_id = find_proxy(ip, port)
        update_proxy(proxy_id, time)
      else
        create_proxy(ip, port, time)
      end
    end

    def self.find_proxy(ip, port)
      proxy = Database[:proxies].where(ip: ip, port: port).first
      proxy ? proxy[:id] : nil
    end
    private_class_method :find_proxy

    def self.update_proxy(proxy_id, time)
      Database[:proxies].where(id: proxy_id).update(
        time: time, status: "checked"
      )
    end
    private_class_method :update_proxy

    def self.create_proxy(ip, port, time)
      Database[:proxies].insert(
        ip: ip, port: port, time: time, status: "checked"
      )
    end
    private_class_method :create_proxy
  end
end
