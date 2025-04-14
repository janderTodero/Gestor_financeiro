class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = current_user.transactions
  
    @total_incomes = @transactions.where(transaction_type: "entrada").sum(:amount)
    @total_expenses = @transactions.where(transaction_type: "saida").sum(:amount)
    @balance = @total_incomes - @total_expenses
  
    # Entradas por categoria
    income_grouped = @transactions.where(transaction_type: "entrada").group(:category).sum(:amount)
    income_total = income_grouped.values.sum
    @income_pie_data = income_grouped.map do |category, amount|
      percentage = (amount.to_f / income_total * 100).round(2)
      [category, percentage]
    end.to_h
  
    # Saídas por categoria
    expense_grouped = @transactions.where(transaction_type: "saida").group(:category).sum(:amount)
    expense_total = expense_grouped.values.sum
    @expense_pie_data = expense_grouped.map do |category, amount|
      percentage = (amount.to_f / expense_total * 100).round(2)
      [category, percentage]
    end.to_h
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = current_user.transactions.build(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_path, status: :see_other, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = current_user.transactions.find(params.expect(:id))
      rescue ActiveRecord::RecordNotFound
      redirect_to transactions_path, alert: "Transação não encontrada."
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.expect(transaction: [ :title, :amount, :description, :transaction_type, :category])
    end
end
