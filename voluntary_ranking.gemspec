$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'voluntary_ranking/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'voluntary_ranking'
  s.version     = VoluntaryRanking::VERSION
  s.authors     = ['TODO: Your name']
  s.email       = ['TODO: Your email']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of VoluntaryRanking.'
  s.description = 'TODO: Description of VoluntaryRanking.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'voluntary_core_module_emberjs', '0.0.1'
end
