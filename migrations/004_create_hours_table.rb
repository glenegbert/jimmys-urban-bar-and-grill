Sequel.migration do
  up do
    create_table(:location_hours) do
      primary_key :id
      String  :day_of_week, :null=>false
      String  :opening_hour, :null=>false
      String  :opening_minute, :null=>false
      String  :opening_period, :null=>false
      String  :closing_hour, :null=>false
      String  :closing_minute, :null=>false
      String  :closing_period, :null=>false
    end
  end

  down do
    drop_table(:location_hours)
  end
end
