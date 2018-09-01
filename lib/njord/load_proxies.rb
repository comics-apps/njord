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
      scope = Database[:proxies].where(status: "checked").order(:time)
      if options[:count]
        scope = scope.limit(options[:count].to_i)
      end
      scope.all
    end
    private_class_method :load_checked
  end
end
