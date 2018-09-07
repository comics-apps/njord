namespace :db do
  task :config do
    Bifrost.config(prefix: "DATABASE")
  end
end
