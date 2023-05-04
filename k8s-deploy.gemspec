# frozen_string_literal: true

require_relative 'lib/k8s-deploy/version'

Gem::Specification.new do |spec|
  spec.name = 'k8s-deploy'
  spec.version = K8sDeploy::VERSION
  spec.authors = ['Oleksii Leonov']
  spec.email = ['mail@oleksiileonov.com', 'oleksii.leonov@syngenta.com', 'ospo@syngenta.com']

  spec.summary = 'k8s-deploy — automate deployments to Google Kubernetes Engine'
  spec.description = 'Automate deployments to Google Kubernetes Engine (GKE)'
  spec.homepage = 'https://github.com/syngenta/k8s-deploy'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.0.0'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'changelog_uri' => 'https://github.com/syngenta/k8s-deploy/blob/main/CHANGELOG.md',
    'source_code_uri' => spec.homepage,
    'documentation_uri' => spec.homepage,
    'bug_tracker_uri' => 'https://github.com/syngenta/k8s-deploy/issues',
    'rubygems_mfa_required' => 'true'
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ docs/ spec/ .git .github .devcontainer])
    end
  end
  spec.extra_rdoc_files = ['LICENSE', 'README.md']

  spec.add_dependency 'rake', '>= 0.8.2'
end
