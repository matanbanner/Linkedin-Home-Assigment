# -*- encoding: utf-8 -*-
# stub: db_fixtures_dump 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "db_fixtures_dump".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kurt Thams".freeze]
  s.date = "2014-11-30"
  s.description = "Rake task to dump ActiveRecord tables into yaml fixtures".freeze
  s.email = ["thams@thams.com".freeze]
  s.homepage = "https://github.com/thams/db_fixtures_dump".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.1".freeze
  s.summary = "Rake task to dump ActiveRecord tables into yaml fixtures. Usage: rake db:fixtures:dump".freeze

  s.installed_by_version = "2.6.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
