Sequel.migration do
  up do
    create_table :species do
      primary_key :id
      String :name, null: false, unique: true
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end

  down do
    drop_table :species
  end
end
