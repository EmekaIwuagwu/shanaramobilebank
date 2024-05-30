class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :fullname
      t.string :telephone
      t.string :email
      t.string :account_num, null: false
      t.decimal :account_bal, precision: 10, scale: 2, default: 0.00

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :account_num, unique: true
  end
end
