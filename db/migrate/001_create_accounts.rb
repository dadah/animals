Sequel.migration do
  up do
    create_table :accounts do
      primary_key :id
      String :name
      String :surname
      String :email, null: false, unique: true
      String :crypted_password, null: false
      String :role
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end

  down do
    drop_table :accounts
  end
end
