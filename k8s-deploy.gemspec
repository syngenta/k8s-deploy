require File.expand_path('../lib/k8s-deploy/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'k8s-deploy'
  s.version     = K8sDeploy::VERSION.dup
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Oleksii Leonov'
  s.email       = 'mail@aleksejleonov.com'
  s.homepage    = 'https://github.com/cropio/k8s-deploy'
  s.summary     = 'automate deploy to Kubernetes.'
  s.description = 'automate deploy to Kubernetes.'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 1.9.1'
  s.add_dependency 'rake', '>= 0.8.2'

  s.files       = `git ls-files`.split("\n")
end
