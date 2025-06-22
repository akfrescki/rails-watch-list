class Movie < ApplicationRecord
  # one movie can appear in many bookmarks
  has_many :bookmarks, dependent: :destroy
  has_many :lists, through: :bookmarks

  # validates the presence of title and overview, and prevents duplicate titles
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
