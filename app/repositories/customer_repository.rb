require "csv"
require_relative "../models/customer"
require_relative "base_repository"

class CustomerRepository < BaseRepository
  def headers
    %w[id name address]
  end

  def save_row(element)
    [element.id, element.name, element.address]
  end

  def load_row(row)
    @elements << Customer.new(row)
  end

end
