class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.string :name
      t.text :description
      t.string :algorithm
      t.datetime :start_at
      t.datetime :won_at
      t.integer :won_by

      t.timestamps
    end
    add_index :contests, :name
    add_index :contests, :won_by
  end
end
