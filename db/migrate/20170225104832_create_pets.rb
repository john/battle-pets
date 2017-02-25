class CreatePets < ActiveRecord::Migration[5.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :strength
      t.integer :intelligence
      t.integer :speed
      t.integer :integrity

      t.timestamps
    end
  end
end
