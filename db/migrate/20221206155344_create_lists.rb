class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.integer :todo_id, null: false
      t.string :title, null: false
      t.boolean :status, null: false, default: false
      # 期間指定、いつからいつまで
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps
    end
  end
end
