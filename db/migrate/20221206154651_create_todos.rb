class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :reason, null: false
      t.boolean :status, null: false

      t.timestamps
    end
  end
end
