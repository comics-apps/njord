require_relative "lib/dependencies"

Rake.add_rakelib("lib/tasks")

spec = Gem::Specification.find_by_name("bifrost")
rakefile = "#{spec.gem_dir}/lib/tasks/db.rake"
load rakefile
