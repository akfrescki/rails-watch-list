# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"
require "json"

puts "Cleaning up database..."

# Destroy bookmarks first to avoid foreign key issues
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "Database cleaned"

puts "Seeding movies from TMDB..."

url = "https://tmdb.lewagon.com/movie/top_rated"
base_poster_url = "https://image.tmdb.org/t/p/original"

10.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)["results"]
  movies.each do |movie|
    puts "Creating #{movie["title"]}"
    Movie.create!(
      title: movie["title"],
      overview: movie["overview"],
      poster_url: "#{base_poster_url}#{movie["backdrop_path"] || movie["poster_path"]}",
      rating: movie["vote_average"]
    )
  end
end

puts "🎉 Movies created!"

List.create!(
  name: 'Avatar',
  banner_url: 'https://picsum.photos/id/870/1200/300?grayscale&blur=2'
)
