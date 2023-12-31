class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer :genre_id
      t.string :name
      t.text :explanation
      t.integer :price
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
