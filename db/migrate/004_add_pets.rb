Sequel.migration do
  up do
    extension :pg_enum
    create_enum :gender, %w'male female unknown'
    create_table :pets do
      primary_key :id
      foreign_key :breed_id, :breeds
      foreign_key :account_id, :accounts
      String :name, null: false
      column :gender, :gender, null: false, default: 'unknown'
      String :colors
      column :description, :text
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
      index :gender
    end
  end

  down do
    extension :pg_enum
    drop_index :pets, :gender
    drop_table :pets
    drop_enum :gender
  end
end
