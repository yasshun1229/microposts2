class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :follow, null: false, foreign_key: { to_table: :users } # 普通はuserカラムを使用するが、上と被ってしまうため、followカラムを使用している。to_tableは、usersテーブルを参照している。

      t.timestamps
      
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
