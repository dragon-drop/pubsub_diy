class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :key
      t.datetime :event_at
      t.string :record_type
      t.integer :record_id
      t.integer :user_id

      t.timestamps
    end
  end
end
