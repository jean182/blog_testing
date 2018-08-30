class Category < ApplicationRecord
  has_many :has_categories, dependent: :destroy
  has_many :posts, through: :has_categories
  accepts_nested_attributes_for :has_categories
  validates :name, presence: true
end
