Sequel.migration do
  up do
    alter_table :accounts do
      add_column :latitude, Float
      add_column :longitude, Float
      add_column :street, String
      add_column :city, String
      add_column :region, String
      add_column :country, String
      add_column :country_code, String
    end
  end

  down do
    alter_table :accounts do
      drop_column :latitude
      drop_column :longitude
      drop_column :street
      drop_column :city
      drop_column :region
      drop_column :country
      drop_column :country_code
    end
  end
end
