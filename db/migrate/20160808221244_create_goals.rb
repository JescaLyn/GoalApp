class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :details
      t.boolean :visible, default: true
      t.boolean :completed, default: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
