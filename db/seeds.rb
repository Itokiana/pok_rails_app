# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# schedules = HorodatorSchedule.where(["created_at::date = ? AND user_id = 13", Date.today])
# inactivities = []
# top_inactivity = nil
# totals = []

# schedules.each do |s|
#   inactivities << s.inactivities.order("total DESC").limit(1)[0]
#   totals << s.inactivities.order("total DESC").limit(1)[0].total.to_i
# end

# # p totals.sort_by { |t| -t }
# p tp inactivities.sort_by { |i| -i.total }


require 'jwt'

# t = JWT.decode("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJsYXN0X2xvZ2luIjoiMjAxOS0xMi0yNiAwNzo0NTo0MiBVVEMifQ.o2NRuQSQ6hQWkjiHtGXQO5ZEWJwaWgkGrHVYmyY2KFg", "glopopopy", true, algorithm: 'HS256')

# p t

o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
string = (0...30).map { o[rand(o.length)] }.join

p string
