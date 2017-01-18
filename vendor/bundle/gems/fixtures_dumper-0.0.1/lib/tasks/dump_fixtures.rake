namespace :db do
  namespace :fixtures do
    desc "Dumps data from database to fixtures"

    task :dump => :environment do

      TABLES_TO_BE_EXCLUDED = %w(schema_migrations delayed_jobs)

      fixtures_path = if ENV['FIXTURES_PATH']
                        File.join(Rails.root, ENV['FIXTURES_PATH'])
                      else
                        File.join(Rails.root, 'test', 'fixtures')
                      end

      connection = ActiveRecord::Base.connection

      if ENV['TABLE'] && connection.tables.exclude?(ENV['TABLE'])
        puts "Table #{ENV['TABLE']} does not exist in the database."
        exit
      end

      if ENV['TABLE'] && connection.tables.include?(ENV['TABLE'])
        tables = Array.wrap ENV['TABLE']
      else
        tables = connection.tables
      end

      actual_tables = tables - TABLES_TO_BE_EXCLUDED

      puts "Dumping fixtures for following tables:\n" << actual_tables.join(", ")

      actual_tables.each do |table|
        begin
          model = table.singularize.camelize.constantize
          data = model.unscoped

          result = []

          if data.count > 0
            data.each do |record|
              result << { "#{table.singularize}_#{record.id}" => record.attributes }
            end

            fixture_file = fixtures_path + "/#{table}.yml"

            puts "Dumping #{data.count} records in #{table}.yml"

            File.open(fixture_file, "w") do |f|
              result.each do |hash|
                f.write(hash.to_yaml.gsub(/^---\s+/,''))
              end
            end

          else
            puts "Table #{table} has 0 records."
          end
        rescue NameError => ex
          puts ex.message
          next
        end
      end
    end
  end
end
