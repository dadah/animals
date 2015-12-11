Sequel.migration do
  up do
    alter_table :pets do
      add_column :size, String
      add_column :deseases, :text
      add_column :weight, Float
      add_column :born_on, Date, null: false
    end
  end

  down do
    alter_table :pets do
      drop_column :size
      drop_column :deseases
      drop_column :weight
      drop_column :born_on
    end
  end
end
