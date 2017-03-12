source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "devise"
gem "devise-token_authenticatable"
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.2'
gem "rails_admin", "1.1.0"
gem "rest-client"
gem 'sass-rails', '~> 5.0'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier', '>= 1.3.0'
# gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# gem "haml-rails"

group :development, :test do
  gem 'byebug', platform: :mri
  gem "bundler-audit"
  gem "dotenv-rails"
  gem 'rspec'
  gem "rspec-rails"
  gem "vcr"
  gem "webmock"
end

group :development do
  gem "html2haml"
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem "factory_girl_rails", :group => [:test]
  gem "shoulda-matchers", :group => [:test]
  gem "rails-controller-testing", :group => [:test]
end
