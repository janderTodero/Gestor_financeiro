require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'Validações' do 
    it 'é válido com atributos válidos' do
      user = User.create!(email: 'teste@email.com', password: '123456')
      transaction = Transaction.new(
        title: 'Salário',
        amount: 5000.0,
        description: 'Salário de agosto',
        transaction_type: 'entrada',
        category: 'salario',
        user: user
      )

      expect(transaction).to be_valid
    end

    it 'é inválido sem um valor' do
    user = User.create!(email: 'teste@email.com', password: '123456')
    transaction = Transaction.new(
      title: 'Salário',
      description: 'Salário de agosto',
      transaction_type: 'entrada',
      category: 'salario',
      user: user
    )

    expect(transaction).not_to be_valid
  end
  end
end
