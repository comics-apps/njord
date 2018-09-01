module Njord
  module LoadProxies
    def self.call(kind = :all, **options)
      kind = [:all, :unchecked, :checked].include?(kind) ? kind : :all
      proxies = send("load_#{kind}", options)

      if block_given?
        proxies.each { |proxy| yield(proxy) }
      else
        proxies
      end
    end

    def self.load_all(_options)
      Database[:proxies].all
    end
    private_class_method :load_all

    def self.load_unchecked(_options)
      Database[:proxies].where(status: "unchecked").all
    end
    private_class_method :load_unchecked

    def self.load_checked(options)
      Database[:proxies]
        .where(status: "checked").order(:time).limit(options[:count] || 1).all
    end
    private_class_method :load_checked
  end
end
