require 'fortnite_opponents_stats/version'

GEM_NAME = 'fortnite-opponents-stats'.freeze
GEM_VERSION = FortniteOpponentsStats::VERSION

task default: :build

task :build do
  system "gem build #{GEM_NAME}.gemspec"
end

task install: :build do
  system "gem install #{GEM_NAME}-#{GEM_VERSION}.gem"
end

task publish: :build do
  system "gem push #{GEM_NAME}-#{GEM_VERSION}.gem"
end

task :clean do
  system 'rm *.gem'
end
