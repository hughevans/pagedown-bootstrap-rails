require File.expand_path('../lib/pagedown_bootstrap/rails/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'pagedown-bootstrap-rails'
  s.version = PageDownBootstrap::Rails::VERSION
  s.description = 'PageDown Bootstrap for the Rails asset pipeline'
  s.summary = 'This gem makes PageDown Bootstrap available in the Rails asset pipeline.'
  s.authors = ['Hugh Evans']
  s.email = ['hugh@artpop.com.au']
  s.date = Time.now.strftime('%Y-%m-%d')
  s.require_paths = ['lib']
  s.add_dependency('railties', '> 3.1')
  s.files = Dir['{lib,vendor}/**/*'] + ['README.md']
  s.homepage = 'http://github.com/hughevans/pagedown-bootstrap-rails'
  s.license = 'MIT'
end
