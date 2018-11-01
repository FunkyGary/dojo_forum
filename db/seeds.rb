# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Comment.destroy_all
Article.destroy_all
Category.destroy_all
User.destroy_all

20.times do |i|
  User.create!(
    name: FFaker::Name.first_name,
    email: FFaker::Internet.email,
    password: "12345678",
    intro: FFaker::Lorem.sentence,
  )
end
puts "have created fake users"
puts "now you have #{User.count} users data"

User.create(email: "admin@example.com", password: "12345678", role:'admin', intro: FFaker::Lorem.sentence, name: 'admin' )
puts 'admin user create'


category_list = [
  { name: "Cat" },
  { name: "Dog" },
  { name: "Hamster" },
]

category_list.each do |category|
  Category.create( name: category[:name] )
end

puts "Category created!"


User.all.each do |user|
  10.times do |i|
    user.articles.create!(
      title:  FFaker::LoremCN.sentence,
      description: FFaker::LoremCN.paragraph,
      category: Category.all.sample,
    )
  end
end

puts "have created fake articles"
puts "now you have #{Article.count} articles data"


Article.all.each do |article|
  3.times do |i|
    article.comments.create!(
      content: FFaker::Lorem.sentence,
      user: User.all.sample
    )
  end
end
puts "have created fake comments"
puts "now you have #{Comment.count} comment data"

Article.all.each do |article|
  article.replies_count = article.comments.size
  article.save
end

User.all.each do |user|
  user.comment_counts = user.comments.size
  user.save
end


