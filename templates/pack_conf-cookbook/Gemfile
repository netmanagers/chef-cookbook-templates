source 'https://rubygems.org'

gem 'chefspec',   '~> 3.2'
gem 'berkshelf',  '~> 3.1.0'
gem 'rake'
gem 'rubocop',    '~> 0.18.1'
gem 'foodcritic'

group :plugins do
  gem "vagrant-berkshelf", github: "berkshelf/vagrant-berkshelf"
  gem "vagrant-omnibus", github: "schisamo/vagrant-omnibus"
end

group :integration do
  gem 'test-kitchen',    '~> 1.2'
  gem 'kitchen-vagrant', '~> 0.14'
end
