Sequel.migration do
  up do
    create_table(:menu_items)
      primary_key :id
      String  :name, :null=>false
      String  :description, :null=>true
      Integer :price, :null=>false
      # Integer :menu_section_id, :null=>false
      # Integer :foregin_key, :null=>false
    end
  end

  down do
    drop_table(:menu_items)
  end
end
