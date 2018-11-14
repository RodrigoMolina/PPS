# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#AdminProfile.create(name: 'Administrador', surname: '', user: User.new(password:'admin@admin.com', email: 'admin@admin.com'))


puts '----------------------------------- Creating WorkshopCategories'
env_seed_file = File.join(Rails.root, 'db', 'seeds', "workshop_categories.rb")
load(env_seed_file) if File.exist?(env_seed_file)

puts '----------------------------------- Creating Countries'
env_seed_file = File.join(Rails.root, 'db', 'seeds', "countries.rb")
load(env_seed_file) if File.exist?(env_seed_file)

puts '----------------------------------- Creating Provinces'
env_seed_file = File.join(Rails.root, 'db', 'seeds', "provinces.rb")
load(env_seed_file) if File.exist?(env_seed_file)

puts '----------------------------------- Creating Cities'
env_seed_file = File.join(Rails.root, 'db', 'seeds', "cities1.rb")
load(env_seed_file) if File.exist?(env_seed_file)
env_seed_file = File.join(Rails.root, 'db', 'seeds', "cities2.rb")
load(env_seed_file) if File.exist?(env_seed_file)
env_seed_file = File.join(Rails.root, 'db', 'seeds', "cities3.rb")
load(env_seed_file) if File.exist?(env_seed_file)
env_seed_file = File.join(Rails.root, 'db', 'seeds', "cities4.rb")
load(env_seed_file) if File.exist?(env_seed_file)
env_seed_file = File.join(Rails.root, 'db', 'seeds', "cities5.rb")
load(env_seed_file) if File.exist?(env_seed_file)



#Dummy data
puts '----------------------------------- Creating Users'
env_seed_file = File.join(Rails.root, 'db', 'seeds', "users.rb")
load(env_seed_file) if File.exist?(env_seed_file)

puts '----------------------------------- Creating Workshops'
env_seed_file = File.join(Rails.root, 'db', 'seeds', "workshops.rb")
load(env_seed_file) if File.exist?(env_seed_file)
