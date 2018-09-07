# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "dotenv"
gem "nokogiri"
gem "rake"
gem "useragents", github: "debbbbie/useragents-rb"

# Database
gem "pg"
gem "sequel"
gem "bifrost", github: "comics-apps/bifrost"

# Processing work
gem "que"
gem "bunny"

group :development do
  gem "foreman"
end

group :test do
  gem "rspec"
  gem "webmock"
end
