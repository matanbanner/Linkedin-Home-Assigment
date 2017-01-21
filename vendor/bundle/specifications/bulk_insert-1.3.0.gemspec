# -*- encoding: utf-8 -*-
# stub: bulk_insert 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bulk_insert".freeze
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jamis Buck".freeze]
  s.date = "2016-11-01"
  s.description = "Faster inserts! Insert N records in a single statement.".freeze
  s.email = ["jamis@jamisbuck.org".freeze]
  s.homepage = "http://github.com/jamis/bulk_insert".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.1".freeze
  s.summary = "An helper for doing batch (single-statement) inserts in ActiveRecord".freeze

  s.installed_by_version = "2.6.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 4.1.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 4.2.0"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 4.1.0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 4.2.0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 4.1.0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 4.2.0"])
  end
end
