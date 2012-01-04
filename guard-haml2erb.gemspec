# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'guard/haml2erb/version'

Gem::Specification.new do |s|
  s.name        = 'guard-haml2erb'
  s.version     = Guard::Haml2ErbVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Laurence A. Lee']
  s.email       = ['rubyjedi@gmail.com']
  s.homepage    = ''
  s.summary     = %q{Guard gem for Haml2Erb}
  s.description = %q{Converts file.html.haml into file.html.erb}

  s.rubyforge_project = 'guard-haml2erb'

  s.add_dependency('guard', '>= 0.4')
  s.add_dependency('haml2erb', '>= 0.3.0.pre.3')

  s.add_development_dependency('rspec')

  s.files         = Dir.glob('{lib}/**/*') + %w[LICENSE README.md Gemfile]
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end
