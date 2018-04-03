class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :author, limit: 50
      t.string :comment, limit: 500
      t.belongs_to :entry, foreign_key: true

      t.timestamps
    end
  end
end
