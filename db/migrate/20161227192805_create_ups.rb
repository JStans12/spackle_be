class CreateUps < ActiveRecord::Migration[5.0]
  def change
    create_table :ups do |t|
      t.string :value
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
