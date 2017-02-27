class CreateTurns < ActiveRecord::Migration[5.0]
  def change
    create_table :turns do |t|
      t.references :battle, foreign_key: true
      t.references :participant, foreign_key: true
      t.references :move, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
