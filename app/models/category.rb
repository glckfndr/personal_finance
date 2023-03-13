class Category < ApplicationRecord
  has_many :operations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def self.get_all_names
    Category.select('name')
  end
end
