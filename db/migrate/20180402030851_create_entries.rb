class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :title, limit: 100
      t.text :body
      t.string :subtitle, limit: 200

      t.timestamps
    end
  end
end
