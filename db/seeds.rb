# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def rand_value
  (rand * 100).round(2)
end

1000.times do
  Report.create(humidity: rand_value, temperature: rand_value, pressure: rand_value * 100)
end
