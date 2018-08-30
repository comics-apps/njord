module Environment
  def self.load
    environment = ENV.fetch("RUBY_ENV", "development")
    return unless ["development", "test"].include?(environment)
    Dotenv.load(".env.#{environment}.local", ".env.#{environment}", ".env")
  end
end
