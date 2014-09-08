class Recipe
  attr_accessor :id, :name, :instructions, :description
  def initialize(recipe_data)
    @id = recipe_data['id']
    @name = recipe_data['name']
    @instructions = recipe_data['instructions']
    @description = recipe_data['description']
  end

  def self.all
    sql = "SELECT * FROM recipes"

    data = db_connection do |conn|
      conn.exec(sql)
    end

    recipes = []

    data.each do |recipe|
      recipes << Recipe.new(recipe)
    end
    recipes
  end

  def self.find(id)
    sql = "SELECT * FROM recipes WHERE recipes.id = $1;"

    data = db_connection do |conn|
      conn.exec_params(sql, [id])
    end

    Recipe.new(data.to_a[0])

  end

  def ingredients

    sql = "select * from ingredients where recipe_id = $1;"
    data = db_connection do |conn|
      conn.exec_params(sql, [@id])
    end
    ingredients = []

    data.each do |ingredient|
      ingredients << Ingredient.new(ingredient)
    end
    ingredients
  end
end

def db_connection
    begin
      connection = PG.connect(dbname: 'recipes')

      yield(connection)
    ensure
      connection.close
    end
  end
