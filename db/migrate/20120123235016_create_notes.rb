class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :domain_id
      t.integer :user_id
      t.integer :content_id

      t.text :text

      t.timestamps
    end
  end
end
