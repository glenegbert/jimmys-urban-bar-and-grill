Sequel.migration do
  up do
    create_table(:menu_items) do
      primary_key :id
      String  :name, :null=>false
      String  :description, :null=>true
      Integer :price, :null=>false
      # Integer :menu_section_id, :null=>false
      # foregin_key :menu_section_id, :null=>false
    end
  end

  down do
    drop_table(:menu_items)
  end
end
