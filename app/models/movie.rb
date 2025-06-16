class Movie < ApplicationRecord
  # one movie can appear in many bookmarks
  # restrict_with_exception means if a movie is associated with a bookmark, it cannot be deleted
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  # validates the presence of title and overview, and prevents duplicate titles
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
