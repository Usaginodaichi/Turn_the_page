class CreateToDoPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :to_do_posts do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      # description・・・説明
      t.string :description, null: false
      t.boolean :status, null: false, default: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
