namespace :transactions do 
  desc "Consolida transações do mês atual e reseta"
  task consolidate: :environment do
    User.find_each do |user|
      transactions = user.transactions.where(
        created_at: Time.current.beginning_of_month..Time.current.end_of_month
      )

      next if transactions.empty?

      income = transactions.where(transaction_type: "entrada").sum(:amount)
      expense = transactions.where(transaction_type: "saida").sum(:amount)
      balance = income - expense

      MonthlyReport.create!(
        user: user,
        month: Time.current.beginning_of_month,
        income: income,
        expense: expense,
        balance: balance,
        data: transactions.as_json(only: [:amount, :transaction_type, :category, :created_at])
      )

      transactions.destroy_all
    end
  end
end