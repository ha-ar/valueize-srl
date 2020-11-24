class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :country_of_incorporation
      t.string :currency_used
      t.integer :user_id

      t.timestamps
    end
  end
end
