# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Category.exists?
  Category.create!(name: "Drama")
  Category.create!(name: "Sci-Fi")
  Category.create!(name: "Love")
  Category.create!(name: "Adventure")
  Category.create!(name: "Romance")
  Category.create!(name: "Family")
  Category.create!(name: "Musical")
  Category.create!(name: "Horror")
  Category.create!(name: "Thriller")
end
