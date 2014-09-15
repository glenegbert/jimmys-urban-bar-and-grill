require 'sequel'

class MenuRepository
  attr_reader :sections, :items

  def initialize(db)
    @sections = db[:menu_sections]
    @items    = db[:menu_items]
  end

  def create_section(attributes)
    sections.insert(attributes)
  end

  def create_item(attributes)
    items.insert(attributes)
  end

  def all_sections
    sections.to_a
  end

  def all_items
    items.to_a
  end
end
