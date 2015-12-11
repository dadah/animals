Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.plugin(:timestamps, :create => :created_at, :update => :updated_at, :update_on_create => true)
Sequel::Model.plugin(:enum)
Sequel::Model.db = case Padrino.env
when :development then Sequel.connect("postgres://localhost/animals_development", :loggers => [logger])
  when :production  then Sequel.connect("postgres://localhost/animals_production",  :loggers => [logger])
  when :test        then Sequel.connect("postgres://localhost/animals_test",        :loggers => [logger])
end
