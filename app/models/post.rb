class Post < ApplicationRecord
    validates :title, presence: true,
                    length: { minimum: 3 }
    validates :description, length: { minimum: 5 }
end
