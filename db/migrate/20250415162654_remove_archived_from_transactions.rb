class RemoveArchivedFromTransactions < ActiveRecord::Migration[8.0]
  def change
    remove_column :transactions, :archived, :boolean
  end
end
