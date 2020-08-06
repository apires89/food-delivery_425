require "csv"
require_relative "../models/meal"
require_relative "base_repository"

class MealRepository < BaseRepository

  def headers
    %w[id name price]
  end

  def save_row(element)
    [element.id, element.name, element.price]
  end

  def load_row(row)
    row[:price] = row[:price].to_i
    @elements << Meal.new(row)
  end
end
