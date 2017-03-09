source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :test do
  gem "rake", "~> 10.0"
  if puppet_gem_version = ENV['PUPPET_GEM_VERSION']
    gem "puppet", puppet_gem_version
  elsif puppet_git_url = ENV['PUPPET_GIT_URL']
    gem "puppet", :git => puppet_git_url
  else
    gem "puppet"
  end
  gem 'puppet-lint', '>= 1.0.0'
  gem "puppet-lint-unquoted_string-check"
  gem "rspec-puppet"
  gem "puppet-syntax"
  gem "puppetlabs_spec_helper", ">= 1.0.0"
  gem "metadata-json-lint"
  gem "rspec"
  gem "rspec-retry"
  gem "simplecov", ">= 0.11.0"
  gem "simplecov-console"
  gem "json_pure", "<= 2.0.1" # 2.0.2 requires Ruby 2+
  gem 'facter', '>= 1.7.0'
end

# rspec must be v2 for ruby 1.8.7
if RUBY_VERSION >= '1.8.7' && RUBY_VERSION < '1.9'
  gem 'rspec', '~> 2.0'
  gem 'rake', '~> 10.0'
else
  # rubocop requires ruby >= 1.9
  gem 'rubocop'
end
