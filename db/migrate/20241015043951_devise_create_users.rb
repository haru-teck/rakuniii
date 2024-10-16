# db/migrate/20241015043951_devise_create_users.rb

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :name,              null: false   # 名前
      t.integer :role_id,           null: false   # 所属（ActiveHashを使用）
      t.string :encrypted_password, null: false, default: ""  # パスワード

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :name, unique: true  # 名前にユニーク制約
    add_index :users, :reset_password_token, unique: true
  end
end
