# frozen_string_literal: true

require_relative "lib/fault_tolerant_requests/version"

Gem::Specification.new do |spec|
  spec.name = "fault_tolerant_requests"
  spec.version = FaultTolerantRequests::VERSION
  spec.authors = ["Nick"]
  spec.email = ["spam@flinkwise.com"]

  spec.summary = "Fault-tolerant GET requests"
  spec.description = "Send GET requests, retry after incremental delays on failure."
  spec.homepage = "https://github.com/nicksterious/fault_tolerant_requests"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  #spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nicksterious/fault_tolerant_requests"
  spec.metadata["changelog_uri"] = "https://github.com/nicksterious/fault_tolerant_requests/CHANGELOG.md"
  # additional links
  spec.metadata["bug_tracker_uri"] = "https://www.sportsbooksoft.com"
  spec.metadata["mailing_list_uri"] = "https://www.sportsbook-provider.com"
  spec.metadata["wiki_uri"] = "https://www.start-sportsbook.com"
  spec.metadata["funding_uri"] = "https://www.sports-book-software.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "uri", "~> 0.12.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
