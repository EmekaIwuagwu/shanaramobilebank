class CreateBeneficiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :beneficiaries do |t|
      t.string :name_in_full
      t.string :account_num
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :beneficiaries, :account_num
  end
end
