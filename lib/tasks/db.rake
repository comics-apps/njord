namespace :db do
  desc "Create database"
  task :create do
    Database.instance.create
  end

  desc "Drop database"
  task :drop do
    Database.instance.drop
  end

  desc "Run migrations"
  task :migrate do
    Sequel.extension(:migration)
    version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    Sequel::Migrator.run(
      Database.instance.connection, 'db/migrations',
      use_transactions: true, target: version
    )
  end
end
