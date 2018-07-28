class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :first_name
      t.string :last_name
      t.boolean :is_bot, null: false, default: false
      t.boolean :has_blocked, null: false, default: false

      t.timestamps
    end
  end
end
