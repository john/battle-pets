class CreateBattles < ActiveRecord::Migration[5.0]
  def change
    create_table :battles do |t|
      t.references :contest, foreign_key: true
      t.datetime :start_at
      t.datetime :won_at
      t.integer :won_by
      t.integer :created_by

      t.timestamps
    end
    add_index :battles, :won_by
    add_index :battles, :created_by
  end
end
