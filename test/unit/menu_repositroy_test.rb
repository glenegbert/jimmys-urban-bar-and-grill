require_relative '../test_helper'
require_relative '../../lib/menu_repository'

describe MenuRepository do
  let(:db) {
    Sequel.connect("postgres://user_name:password@localhost:5432/jimmys_test")
  }
  let(:repository) {
     MenuRepository.new(db)
  }

  before do
    db.create_table! :menu_items do
      primary_key :id
      String :name, :null=>false
      String :description, :null=>true
      Float :price, :null=>false
      String :menu_section, :null=>false
    end

    db.create_table! :menu_sections do
      primary_key :id
      String :name, :null=>false
      String :description, :null=>true
    end
  end

  it 'can create menu items' do
    description = "Do #{rand(2..20) things}"
    items = repositroy.all_items
    assert
  end
