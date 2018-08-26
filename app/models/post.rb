class Post < ApplicationRecord
    has_many :comments, dependent: :destroy

    validates :title, presence: true,
                    length: { minimum: 3 }
    validates :description, length: { minimum: 5 }
end
