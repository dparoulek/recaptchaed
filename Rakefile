require 'rake'
require 'rake/rdoctask'
require 'rake/gempackagetask'

desc 'Default: gem'
task :default => :gem

PKG_FILES = FileList[
  '[a-zA-Z]*',
  'generators/**/*',
  'lib/**/*',
  'rails/**/*',
  'tasks/**/*',
  'spec/**/*'
]

spec = Gem::Specification.new do |s|
  s.name = "recaptchaed"
  s.version = "1.0.0"
  s.author = "Dave Paroulek"
  s.email = "dave@daveparoulek.com"
  s.homepage = "http://upgradingdave.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "Rails Plugin that makes it super easy to add recaptcha to any model form"
  s.files = PKG_FILES.to_a
  s.require_path = "lib"
  s.has_rdoc = false
  s.extra_rdoc_files = ["README"]
end

desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc 'Generate documentation for the recaptchaed plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Recaptchaed'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
