Sequel.migration do
  up do
    extension :pg_enum
    create_enum :account_type, %w'personal association'
    alter_table :accounts do
      add_column :phone_number, String
      add_column :account_class, :account_type, null: false, default: 'personal'
      add_column :bio, :text
      add_column :pets_count, Integer, default: 0, null: false
    end
  end

  down do
    extension :pg_enum
    alter_table :accounts do
      drop_column :phone_number
      drop_column :account_class
      drop_column :bio
      drop_column :pets_count
    end
    drop_enum :account_type
  end
end
