require 'pry'
module Market
  attr_reader :items

  def items
    {
      CH1: '$3.11',
      AP1: '$6.00',
      CF1: '$11.23',
      MK1: '$4.75'
    }
  end

  def monetize(item)
    item.tr('$','').to_f
  end
end

class Checkout
  include Market

  def initialize(*pricing_rules)
    @all_items = []
    @rule = Rule.new(pricing_rules)
  end

  def total
    list_out_items
    add_item_prices
    discounted_total = @rule.apply_discount(@all_items, @current_total)
    format_money_to_string(discounted_total)
  end

  def scan(item)
    @all_items << item
    items[item.to_sym]
  end


  private
  def format_money_to_string(discounted_total)
    rounded_price = discounted_total.round(2)
    "$#{rounded_price}"
  end

  def add_item_prices
    @current_total = @listed_prices.inject(:+)
  end

  def list_out_items
    @listed_prices = @all_items.map { |item| monetize(items[item.to_sym]) }
  end

end

class Rule
  include Market
  attr_reader :pricing_rules

  def initialize(rules)
    @pricing_rules = rules
  end

  def apply_discount(all_items, current_total)
    @all_items = all_items
    @current_total = current_total
    @pricing_rules.each do |rule|
      if rule == 'BOGO'
        calculate_coffee
      elsif rule == 'APPL'
        calculate_apples
      elsif rule == 'CHMK'
        calculate_chai
      end
    end
    @current_total
  end

  private
  def calculate_coffee
    number_of_coffees = (@all_items.count('CF1')) / 2
    current_cost_coffee = monetize(items[:CF1])
    @current_total = @current_total - (current_cost_coffee * number_of_coffees)
  end

  def calculate_apples
    number_of_apples = @all_items.count('AP1')
    if number_of_apples >= 3
      current_cost_apples = monetize(items[:AP1])
      cost_deducted = current_cost_apples - 4.5
      @current_total = @current_total - (cost_deducted * number_of_apples)
    end
  end

  def calculate_chai
    number_of_chais = @all_items.count('CH1')
    number_of_milks = @all_items.count('MK1')
    if number_of_milks >=1 && number_of_chais >=1
      milk_cost = monetize(items[:MK1])
      @current_total = @current_total - milk_cost
    end
  end
end
