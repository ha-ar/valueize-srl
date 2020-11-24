class CreateCashManagments < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_managments do |t|
      t.integer :initial_cash
      t.integer :cash_in
      t.integer :revenues
      t.integer :equity
      t.integer :convertibe_note
      t.integer :bank_debt
      t.integer :cashin_others
      t.integer :cash_out
      t.integer :cogs
      t.integer :employees
      t.integer :services
      t.integer :operation_expenses
      t.integer :investments
      t.integer :cashout_others
      t.integer :end_cash_balance
      t.integer :company_id

      t.timestamps
    end
  end
end
