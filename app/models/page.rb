class Page < ApplicationRecord
    store :content, accessors: [ :h1, :h2, :h3, :link ], coder: JSON
    validates :url, presence: true, uniqueness: true
end
