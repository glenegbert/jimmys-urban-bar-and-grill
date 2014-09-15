Sequel.migration do
  up do
    create_table(:menu_items)
      primary_key :id
      String :name, :null=>false
      String :description, :null=>true
      Float :price, :null=>false
      String :menu_section, :null=>false
    end
  end

  down do
    drop_table(:menu_items)
  end
end
