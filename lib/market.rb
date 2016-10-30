require 'pry'
class Checkout
  ITEMS = {
            CH1: '$3.11',
            AP1: '$6.00',
            CF1: '$11.23',
            MK1: '$4.75'
          }

  def initialize
    @all_items = []
    @current_total = []
  end

  def scan(item)
    @all_items << item
    ITEMS[item.to_sym]
  end

  def list_out_items
    @current_total = @all_items.map do |item|
      monetize(ITEMS[item.to_sym])
    end
  end

  def total
    list_out_items
    sum = @current_total.inject(:+)
    format_money(sum)
  end

  private
  def monetize(item)
    item.tr('$','').to_f
  end

  def format_money(item)
    "$#{item}"
  end
end