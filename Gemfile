# encoding: UTF-8
source "https://rubygems.org"

# testing
group :test do
  # rake testing
  gem "rake", "~> 10.4.2"
  gem "rubocop", "~> 0.33.0"
end

# integration testing
group :integration do
  # test-kitchen testing
  gem "test-kitchen", "~> 1.4.2"
  gem "kitchen-ansible", "~> 0.0.23"
  gem "kitchen-vagrant", "~> 0.18"
  gem "serverspec", "~> 2.21.1"
end

# development and debugging
group :development do
  gem "pry", "~> 0.10"
  gem "pry-coolline", "~> 0.2"
  gem "pry-rescue", "~> 1.4"
  gem "pry-stack_explorer", "~> 0.4"
end
