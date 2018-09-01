module Njord
  module SendProxies
    def self.call(proxies)
      connection = Bunny.new
      connection.start
      channel = connection.create_channel
      queue = channel.queue("new_proxies")

      # Declare a default direct exchange which is bound to all queues
      exchange = channel.exchange("")

      # Publish a message to the exchange which then gets routed to the queue
      exchange.publish(parse_proxies(proxies), key: queue.name)

      connection.close

      DeleteProxies.call(id: proxy_ids(proxies))
    end

    def self.proxy_ids(proxies)
      proxies.map{ |proxy| proxy[:id] }
    end
    private_class_method :proxy_ids

    def self.parse_proxies(proxies)
      proxies.map { |proxy| "#{proxy[:ip]}:#{proxy[:port]}" }.join(";")
    end
    private_class_method :parse_proxies
  end
end
