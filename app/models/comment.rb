class Comment < ApplicationRecord
  belongs_to :post

  validates :commenter, presence: true,
  length: { minimum: 3 }

  validates :body, length: { minimum: 5 }
end
