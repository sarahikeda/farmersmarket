require 'pry'
class Checkout
  ITEMS = {
            CH1: '$3.11',
            AP1: '$6.00',
            CF1: '$11.23',
            MK1: '$4.75'
          }

  def initialize

  end

  def scan(item)
    ITEMS[item.to_sym]
  end
end