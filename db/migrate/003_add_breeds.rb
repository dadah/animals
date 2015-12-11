Sequel.migration do
  up do
    create_table :breeds do
      primary_key :id
      foreign_key :species_id, :species
      String :name, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end

  down do
    drop_table :breeds
  end
end
