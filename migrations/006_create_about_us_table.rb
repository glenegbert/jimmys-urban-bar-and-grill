Sequel.migration do
  up do
    create_table(:about_us) do
      primary_key :id
      String  :title1, :null=>false
      String  :paragraph1, :null=>false
      String  :title2, :null=>false
      String  :paragraph2, :null=>false
    end
  end

  down do
    drop_table(:about_us)
  end
end
