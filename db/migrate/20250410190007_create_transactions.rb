class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :title
      t.decimal :amount
      t.text :description
      t.string :transaction_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
