class AddPageReferenceToUps < ActiveRecord::Migration[5.0]
  def change
    add_reference :ups, :page, foreign_key: true
  end
end
