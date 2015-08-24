# clean.mk

## Environment variables
#
# There are a number of environment variables which can be overriden for local
# use. In that case, simply use `make -e` to use overrides with `make`.
#
BUNDLE_OPTS=''
RBENV_VERSION=2.1.6

## Cleanup
#
clean: clean/rbenv clean/bundle clean/kitchen

# clean out bundle, if needed
clean/bundle: clean/rbenv
	bundle check || bundle $(BUNDLE_OPTS) || bundle clean --force || \
	rm -f Gemfile.lock

# destroy any test-kitchen instances, if they exist
clean/kitchen: bundler
	if [ -d .kitchen ]; then bundle exec kitchen destroy -c; fi

# only set up rbenv if rbenv is installed
clean/rbenv:
	if [ `which rbenv` ]; then \
		(rbenv local $(RBENV_VERSION) || \
			(rbenv install $(RBENV_VERSION) && rbenv local $(RBENV_VERSION))) && \
		rbenv exec gem install bundler --no-ri --no-rdoc && rbenv rehash; \
	fi

# bundler without development stuff
bundler: clean/rbenv
	bundle $(BUNDLE_OPTS)
