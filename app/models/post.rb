class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :has_categories, dependent: :destroy
  has_many :categories, through: :has_categories

  validates :title, presence: true, length: { minimum: 3 }
  validates :description, length: { minimum: 5 }
end
