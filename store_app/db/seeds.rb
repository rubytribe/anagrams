User.create!(name:  "Example User",
             email: "example@gmail.com",
             password:              "example",
             password_confirmation: "example",
             picture: File.new("app/assets/images/profile_pictures/default_profile.jpg"),
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  picture = File.new("app/assets/images/profile_pictures/default_profile.jpg")
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               picture: picture)
end
