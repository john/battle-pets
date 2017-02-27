#User.create(name: 'Abe Vigoda', email: 'abe@test.com', password: '1234abcd')

# t.string :name
# t.text :description
# t.string :algorithm
# t.datetime :start_at
# t.datetime :won_at
# t.integer :created_by
# t.integer :won_by

#

Contest.create(name: "Feats of Strength", description: "Let's rumble!",
                winning_characteristic: "strength")
Contest.create(name: "Battle of the Wits", description: "Never go against a Sicilian when death is on the line!",
                winning_characteristic: "intelligence")

