# -*- encoding: utf-8 -*-
# stub: linkedin-scraper 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "linkedin-scraper".freeze
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Yatish Mehta".freeze]
  s.date = "2016-05-19"
  s.description = "Scrapes the LinkedIn profile using the public url ".freeze
  s.executables = ["linkedin-scraper".freeze]
  s.files = ["bin/linkedin-scraper".freeze]
  s.homepage = "https://github.com/yatishmehta27/linkedin-scraper".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.1".freeze
  s.summary = "when a url of  public linkedin profile page is given it scrapes the entire page and converts into a accessible object".freeze

  s.installed_by_version = "2.6.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mechanize>.freeze, ["~> 2"])
      s.add_runtime_dependency(%q<random_user_agent>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10"])
    else
      s.add_dependency(%q<mechanize>.freeze, ["~> 2"])
      s.add_dependency(%q<random_user_agent>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_dependency(%q<rake>.freeze, ["~> 10"])
    end
  else
    s.add_dependency(%q<mechanize>.freeze, ["~> 2"])
    s.add_dependency(%q<random_user_agent>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3"])
    s.add_dependency(%q<rake>.freeze, ["~> 10"])
  end
end
