namespace :db do
  desc "Create database"
  task :create => :environment do
    Database.instance.create
  end

  desc "Drop database"
  task :drop => :environment do
    Database.instance.drop
  end
end
