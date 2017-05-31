require 'rubygems'
require 'rake'

begin
  gem 'rspec', '~> 3.6.0'

  require 'rspec'
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new
rescue LoadError => e
  task :spec do
    abort "Please run `gem install rspec` to install RSpec."
  end
end

task :default => :spec

begin
  gem 'yard', '~> 0.9.9'

  require 'yard'

  YARD::Rake::YardocTask.new  
rescue LoadError => e
  task :yard do
    abort "Please run `gem install yard` to install YARD."
  end
end
