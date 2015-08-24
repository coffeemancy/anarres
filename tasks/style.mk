# style.mk

### Style testing
#
style: style/rubocop

# run rubocop from `rake` task
style/rubocop: bundler
	bundle exec rake style:ruby
