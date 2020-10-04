require_relative 'lib/fortnite_opponents_stats/version'

Gem::Specification.new do |spec|
  spec.name          = 'fortnite-opponents-stats'
  spec.version       = FortniteOpponentsStats::VERSION
  spec.authors       = ['prudi']

  spec.summary       = 'Gem that provides real time stats from opponents you are playing against at a Fortnite match.'
  spec.description   = 'Collect screen captures from your gameplay and parse the opponent names from the bottom left corner action logs.'
  spec.homepage      = 'https://github.com/francoprud/fortnite-opponents-stats'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/francoprud/fortnite-opponents-stats'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split('\x0').reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
