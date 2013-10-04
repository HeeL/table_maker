class Item < ActiveRecord::Base

  has_and_belongs_to_many :tables


  def self.create_from_row(row, table)
    row = row.first.split(';');
    create(
      table_ids: [table.id],
      kind: row[0].strip,
      height: row[1].strip,
      emergency_exit: to_bool(row[2]),
      openable: to_bool(row[3])
    )
  end

  def self.search(params, table_id)
    Table.find(table_id).items.where(search_conditions(params))
  end

  private

  def self.search_conditions(params)
    conds = []
    (0..(params[:value].count - 1)).each do |i|
      conds << "#{params[:field][i.to_s]} #{params[:sign][i.to_s]} #{param_value(params[:value][i.to_s])} "
    end
    sanitize_sql(conds.join(' AND '))
  end

  def self.to_bool(str)
    str.strip.downcase == 'true'
  end

  def self.param_value(str)
    value = str.downcase
    if value == 'true' || value == 'yes'
      str = 'true'
    elsif value == 'false' || value == 'no'
      str = 'false'
    elsif value =~ /^[0-9]+$/
    else
      str = "'#{str}'"
    end
    str
  end

end
