namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :settings do |t, args|
    require 'sequel/core'
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      migrations = File.expand_path('../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      db.extension :schema_dumper

      File.open('db/schema.rb', 'w') do |file|
        file << db.dump_schema_migration(same_db: true, indexes: true, foreign_keys: true)
      end
    end
  end
end
