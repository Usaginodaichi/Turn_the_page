class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # フォローする側
      t.references :follower, foreign_key: { to_table: :users }
      # フォローされる側
      t.references :followed, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
