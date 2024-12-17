class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title, null: false
      t.datetime :date, null: false
      t.string :location, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
