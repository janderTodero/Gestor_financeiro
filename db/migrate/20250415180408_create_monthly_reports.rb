class CreateMonthlyReports < ActiveRecord::Migration[8.0]
  def change
    create_table :monthly_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.date :month
      t.decimal :income
      t.decimal :expense
      t.decimal :balance
      t.jsonb :data

      t.timestamps
    end
  end
end
