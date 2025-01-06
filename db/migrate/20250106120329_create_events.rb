class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.datetime :date
      t.integer :available_tickets, default: 0
      t.integer :total_tickets, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
