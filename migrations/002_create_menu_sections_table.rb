Sequel.migration do
  up do
    create_table(:menu_sections)
      primary_key :id
      String :name, :null=>false
      String :details, :null=>true
    end
  end

  down do
    drop_table(:menu_sections)
  end
end
