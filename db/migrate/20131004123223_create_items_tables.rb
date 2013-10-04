class CreateItemsTables < ActiveRecord::Migration
  def change
    create_table :items_tables do |t|
      t.belongs_to :table
      t.belongs_to :item
    end
  end
end
