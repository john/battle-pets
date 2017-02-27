class CreatePets < ActiveRecord::Migration[5.0]
  def change
    create_table :pets do |t|
      t.string :uuid
      t.string :name
      t.integer :strength
      t.integer :intelligence
      t.integer :speed
      t.integer :integrity

      t.timestamps
    end
    add_index :pets, :name
    add_index :pets, :uuid
  end
end
