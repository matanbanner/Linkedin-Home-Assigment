module FixturesDumper
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/dump_fixtures.rake"
    end
  end
end
