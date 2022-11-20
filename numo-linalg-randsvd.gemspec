# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'numo-linalg-randsvd'
  spec.version = '0.2.0'
  spec.authors = ['yoshoku']
  spec.email = ['yoshoku@outlook.com']

  spec.summary = <<~MSG
    Numo::Linalg.randsvd is a module function on Numo::Linalg for
    truncated singular value decomposition with randomized algorithm.
  MSG
  spec.description = <<~MSG
    Numo::Linalg.randsvd is a module function on Numo::Linalg for
    truncated singular value decomposition with randomized algorithm.
  MSG
  spec.homepage = 'https://github.com/yoshoku/numo-linalg-randsvd'
  spec.license = 'BSD-3-Clause'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['documentation_uri'] = 'https://yoshoku.github.io/numo-linalg-randsvd/doc/'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
                     .select { |f| f.match(/\.(?:rb|rbs|md|txt)$/) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'numo-linalg', '>= 0.1.4'
  spec.add_dependency 'numo-narray', '>= 0.9.1'
  spec.add_dependency 'numo-random', '~> 0.4'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
