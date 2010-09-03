# encoding: utf-8

require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "mongorb"
    gem.summary = %Q{A mongodb Ruby object mapper based on ActiveModel and Arel.}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "liang(dot)gimi(at)gmail(dot)com"
    gem.homepage = "http://github.com/Gimi/mongorb"
    gem.authors = ["梁智敏(Gimi Liang)"]
    gem.add_dependency 'activemodel', '~> 3'
    gem.add_dependency 'activesupport', '~> 3'
    gem.add_development_dependency "minitest", ">= 0"
    gem.add_development_dependency "yard", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

#task :default => :test

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

task :t do
  ruby 'test.rb'
end

task :default => :t
