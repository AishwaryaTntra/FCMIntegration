class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :body
      t.json :data, default: {}
      t.references :notifiable, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
