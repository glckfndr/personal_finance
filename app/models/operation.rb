class Operation < ApplicationRecord
  belongs_to :category
  validates :description, presence: true
  validates :odate, presence: true
  validates :amount, numericality: { greater_than: 0.0 }
  paginates_per 8

  def self.get_sum_for_all_category(start_date, end_date, operation_type)
    Operation.select(:id, :name, :amount).joins(:category)
             .where('odate BETWEEN ? AND ?', start_date, end_date)
             .where(operation_type: operation_type)
             .group('name')
             .sum(:amount)
             .sort_by { |key, val| -val }
  end

  def self.get_sum_on_dates(start_date, end_date, op_type, category_name)
    if (category_name != "All")
      dat = Operation.select('id, name, amount , date(odate)').joins(:category)
                     .where('date(odate) BETWEEN ? AND ?  AND operation_type = ? ', start_date, end_date, op_type)
                     .where('name = ?', category_name)
                     .group('date(odate)')
                     .sum('amount')
    else

      Operation.select('id, name, amount , date(odate)').joins(:category)
               .where('date(odate) BETWEEN ? AND ?  AND operation_type = ? ', start_date, end_date, op_type)
               .group('date(odate)')
               .sum('amount')
    end
  end

  def self.search_by_name_id(name, id)
    Operation.where("description LIKE ? OR operation_type LIKE ? OR category_id = ?", name, name, id)
  end
end
