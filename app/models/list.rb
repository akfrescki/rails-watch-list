class List < ApplicationRecord
  # destroy bookmarks if a list is deleted
  has_many :bookmarks, dependent: :destroy
  # "Hey Rails, from a List, I want access to all the Movies through the Bookmarks table"
  has_many :movies, through: :bookmarks

  validates :name, presence: true, uniqueness: true
end
