# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "admin@example.com", password: "12345678", role:'admin')

puts 'admin user create'

Category.destroy_all

category_list = [
  { name: "Cat" },
  { name: "Dog" },
  { name: "Hamster" },
]

category_list.each do |category|
  Category.create( name: category[:name] )
end

puts "Category created!"

Article.destroy_all

100.times do 
  Article.create!(
    title:  FFaker::LoremCN.sentence,
    description: FFaker::LoremCN.paragraph,
    category: Category.all.sample,
  )
end
puts "have created fake articles"
puts "now you have #{Article.count} articles data"


