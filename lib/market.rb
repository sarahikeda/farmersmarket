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
    @pricing_rules = pricing_rules
  end

  def total
    list_out_items
    add_item_prices
    apply_rules if @pricing_rules.any?
    format_money_to_string(@current_total)
  end

  def scan(item)
    @all_items << item
    ITEMS[item.to_sym]
  end

  def list_out_items
    @listed_prices = @all_items.map { |item| monetize(ITEMS[item.to_sym]) }
  end

  def apply_rules
    @pricing_rules.each do |rule|
      if rule == 'BOGO'
        calculate_coffee
      elsif rule == 'APPL'
        calculate_apples
      elsif rule == 'CHMK'
        calculate_chai
      end
    end
  end

  private
  def monetize(item)
    item.tr('$','').to_f
  end

  def format_money_to_string(current_total)
    rounded_price = current_total.round(2)
    "$#{rounded_price}"
  end

  def add_item_prices
    @current_total = @listed_prices.inject(:+)
  end

  def calculate_coffee
    number_coffees = (@all_items.count('CF1')) / 2
    current_cost_coffee = monetize(ITEMS[:CF1])
    @current_total = @current_total - (current_cost_coffee * number_coffees)
  end

  def calculate_apples
    number_apples = @all_items.count('AP1')
    if number_apples >= 3
      current_cost_apples = monetize(ITEMS[:AP1])
      cost_deducted = current_cost_apples - 4.5
      @current_total = @current_total - (cost_deducted * number_apples)
    end
  end

  def calculate_chai
    number_chai = @all_items.count('CH1')
    number_milk = @all_items.count('MK1')
    if number_milk >=1 && number_chai >=1
      milk_cost = monetize(ITEMS[:MK1])
      @current_total = @current_total - milk_cost
    end
  end

end