class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.string :name
      t.text :description
      t.string :algorithm
      t.string :winning_characteristic
      t.integer :created_by

      t.timestamps
    end
    add_index :contests, :name
    add_index :contests, :created_by
  end
end
