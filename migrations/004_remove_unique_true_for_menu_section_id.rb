Sequel.migration do
  up do
    alter_table(:menu_items) do
      drop_column(:menu_section_id)
      add_column(:menu_section_id, Integer, :null => false)
    end
  end

  down do
    alter_table(:menu_items) do
      drop_column(:menu_section_id)
      add_column(:menu_section_id, Integer, :null => false)
    end
  end
end
