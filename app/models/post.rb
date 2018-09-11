class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :has_tags, dependent: :destroy
  has_many :tags, through: :has_tags

  validates :title, presence: true, length: { minimum: 3 }
  validates :description, length: { minimum: 5 }
end
