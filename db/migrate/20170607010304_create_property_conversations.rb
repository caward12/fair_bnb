class CreatePropertyConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :property_conversations do |t|
      t.references :user, foreign_key: true
      t.references :property, foreign_key: true
      t.integer :cid
    end
  end
end
