class Table < ActiveRecord::Base

  has_and_belongs_to_many :items

  def self.create_from_csv(csv)
    table = create_table
    first_line = true
    CSV.parse(csv.read) do |row|
      if first_line || !row.present?
        first_line = false
        next
      end
      Item.create_from_row(row, table)
    end
    table
  end

  def self.create_sub_table(items)
    table = create_table
    items.each do |item|
      ItemsTables.create(item_id: item.id, table_id: table.id)
    end
  end

  private

  def self.create_table
    create(name: Time.now.to_i, show: true)
  end

end
