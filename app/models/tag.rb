class Tag < ApplicationRecord
  has_many :has_tags, dependent: :destroy
  has_many :posts, through: :has_tags
  accepts_nested_attributes_for :has_tags
  validates :name, presence: true
end
