# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Interaction.destroy_all

User1 = User.create(name: "Smitty")
Int1 = Interaction.create(move: "(251,281)(624,158)(1028,149)(670,188)(506,170)(331,191)(169,28)(813,26)(567,273)(625,14)(17,197)(363,208)", time: "1395371482501", user_id: User1.id)
