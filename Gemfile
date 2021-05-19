source 'https://rubygems.org'

git_source(:github) do |repo|
  "https://github.com/#{repo}.git"
end
ruby '2.5.3'
gem 'faraday'
gem 'fast_jsonapi'
gem 'figaro', git: 'https://github.com/bpaquet/figaro.git', branch: 'sinatra'
gem 'require_all'
gem 'sinatra-contrib'
gem 'shotgun'
gem 'sinatra', require: 'sinatra/base'
gem 'addressable'
gem 'json'
group :development, :test do
  gem 'pry'
end

group :test do
  gem 'factory_bot'
  gem 'faker'
  gem 'rspec'
  gem 'rack-test'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end
