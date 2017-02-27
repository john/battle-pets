class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.references :battle, foreign_key: true
      t.references :pet, foreign_key: true
      t.integer :created_by

      t.timestamps
    end
    add_index :participants, :created_by
  end
end
