class Ingredient
  attr_accessor :id, :name

  def initialize(ingredient_data)
    @id = ingredient_data['id']
    @name = ingredient_data['name']
  end
end
