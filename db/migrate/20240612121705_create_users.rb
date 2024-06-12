class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :phone_number, null: false
      t.string :full_name
      t.string :password_digest, null: false
      t.string :key, null: false
      t.string :account_key
      t.string :metadata

      t.index :email, unique: true
      t.index :phone_number, unique: true
      t.index :key, unique: true
      t.index :account_key, unique: true

      t.timestamps
    end
  end
end
