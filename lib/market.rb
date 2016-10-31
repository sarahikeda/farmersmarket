require 'pry'
class Checkout
  attr_reader :pricing_rules

  ITEMS = {
            CH1: '$3.11',
            AP1: '$6.00',
            CF1: '$11.23',
            MK1: '$4.75'
          }

  def initialize(*pricing_rules)
    @all_items = []
    @current_total = []
    @pricing_rules = pricing_rules
  end

  def apply_rules
    @pricing_rules.each do |rule|
      if rule == 'BOGO'
        number_coffees = (@all_items.count('CF1')) / 2
        @sum = @sum - (monetize(ITEMS[:CF1]) * number_coffees )
      elsif rule == 'APPL'
        number_apples = @all_items.count('AP1')
        if number_apples >= 3
          current_cost_apples = monetize(ITEMS[:AP1])
          cost_deducted = current_cost_apples - 4.5
          @sum = @sum - (cost_deducted * number_apples)
        else
          @sum
        end
      elsif rule == 'CHMK'
        number_chai = @all_items.count('CH1')
        number_milk = @all_items.count('MK1')
        if number_milk >=1 && number_chai >=1
          milk_cost = monetize(ITEMS[:MK1])
          @sum = @sum - (milk_cost)
        else
          @sum
        end
      end
    end
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
    @sum = @current_total.inject(:+).round(2)
    if @pricing_rules.any?
      apply_rules
      @sum = @sum.round(2)
    end
    format_money(@sum)
  end

  private
  def monetize(item)
    item.tr('$','').to_f
  end

  def format_money(item)
    "$#{item}"
  end
end