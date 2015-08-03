=begin
User.create!(name:  "Raul",
             email: "raul@raul.com",
             password:              "password",
             password_confirmation: "password",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
=end
Product.create!(name:  "Table for all",
                description: "The Master Table",
                image_url:   File.new("app/assets/images/table9.jpg"),
                price: "10000")

99.times do |n|
  name  = Faker::Name.name
  description = "example-#{n+1}description#{n}"
  image_url = File.new("app/assets/images/table5.jpg")
  price = n+1
  Product.create!(name:        name,
                  description: description,
                  image_url:   image_url,
                  price:       price)
end
