class CreateCalculateProfits < ActiveRecord::Migration[7.1]
  def change
    create_table :calculate_profits do |t|
      t.string :address
      t.integer :loan_term
      t.decimal :purchase_price
      t.decimal :repair_budget
      t.decimal :arv
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
