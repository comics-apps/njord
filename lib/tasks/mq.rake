namespace :mq do
  desc "Test receiving data via RabbitMQ"
  task :recv, [:queue] do |_t, args|
    require_relative "../njord"

    # message queue
    connection = Bunny.new
    connection.start
    channel = connection.create_channel
    queue = channel.queue(args[:queue])

    begin
      puts " [*] Waiting for messages. To exit press CTRL+C"
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        puts " [x] Consumed the message: []"

        puts body
      end
    rescue Interrupt => _
      connection.close
      exit(0)
    end
  end

  desc "Test sending data via RabbitMQ"
  task :send, [:queue, :message] do |_t, args|
    require_relative "../njord"

    connection = Bunny.new
    connection.start
    channel = connection.create_channel
    queue = channel.queue(args[:queue])

    # Declare a default direct exchange which is bound to all queues
    exchange = channel.exchange("")

    # Publish a message to the exchange which then gets routed to the queue
    exchange.publish(args[:message], key: queue.name)

    connection.close
  end
end
