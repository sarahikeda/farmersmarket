require 'rspec'
require 'pry'
require_relative '../lib/market'

describe Checkout do
  let(:checkout) { Checkout.new }
  let(:checkout_with_coffee_rule) { Checkout.new('BOGO')}
  let(:checkout_with_rules) { Checkout.new('BOGO', 'APPL')}

  context 'initial set up of checkout system' do
    it 'should allow checkout systems without pricing rules' do
      expect(checkout.pricing_rules).to eq []
    end

    it 'should allow checkout systems with a pricing rule' do
      expect(checkout_with_coffee_rule.pricing_rules).to eq(['BOGO'])
    end

    it 'should allow checkout systems with multiple pricing rules' do
      expect(checkout_with_rules.pricing_rules).to eq(['BOGO', 'APPL'])
    end

  end

  context 'scanning products' do
    let(:checkout) { Checkout.new }
    it 'should return one chai with a value of $3.11' do
      expect(checkout.scan('CH1')).to eq ('$3.11')
    end

    it 'should return one bag of apples with a value of $6.00' do
       expect(checkout.scan('AP1')).to eq ('$6.00')
    end

     it 'should return one coffee with a value of $11.23' do
       expect(checkout.scan('CF1')).to eq ('$11.23')
    end

    it 'should return one order of milk with a value of $4.75' do
      expect(checkout.scan('MK1')).to eq ('$4.75')
    end

  end

  context 'interpreting rules' do
    let(:checkout_with_apple_rule) { Checkout.new('APPL')}
    let(:checkout_with_chai_rule) { Checkout.new('CHMK')}

    it 'should appropriately calculate buy one get one free coffee' do
      2.times do
        checkout_with_coffee_rule.scan('CF1')
      end
      expect(checkout_with_coffee_rule.total).to eq("$11.23")
    end

    it 'should appropriately calculate buying 2 apple bags' do
      2.times do
        checkout_with_apple_rule.scan('AP1')
      end
      expect(checkout_with_apple_rule.total).to eq("$12.0")
    end

    it 'should appropriately calculate buying 3 apple bags' do
      3.times do
        checkout_with_apple_rule.scan('AP1')
      end
      expect(checkout_with_apple_rule.total).to eq("$13.5")
    end

     it 'should appropriately calculate buying 5 apple bags' do
      5.times do
        checkout_with_apple_rule.scan('AP1')
      end
      expect(checkout_with_apple_rule.total).to eq("$22.5")
    end

    it "should appropriately calculate buying two chais and one milk" do
      2.times do
        checkout_with_chai_rule.scan('CH1')
      end
      checkout_with_chai_rule.scan('MK1')
      expect(checkout_with_chai_rule.total).to eq("$6.22")
    end


    it "should appropriately calculate buying two chais and two milks" do
      2.times do
        checkout_with_chai_rule.scan('CH1')
        checkout_with_chai_rule.scan('MK1')
      end
      expect(checkout_with_chai_rule.total).to eq("$10.97")
    end

    it "should appropriately calculate buying two chais and no milk" do
      2.times do
        checkout_with_chai_rule.scan('CH1')
      end
      expect(checkout_with_chai_rule.total).to eq("$6.22")
    end


  end

  context 'totaling products sold' do
    let(:checkout) { Checkout.new }
    let(:checkout_with_chai_rule) { Checkout.new('CHMK')}

    it 'should keep track of the running total' do
      checkout.scan('MK1')
      checkout.scan('AP1')
      expect(checkout.total).to eq ('$10.75')
    end

    it 'should keep track of the running total' do
      checkout_with_chai_rule.scan('CH1')
      checkout_with_chai_rule.scan('AP1')
      checkout_with_chai_rule.scan('CF1')
      checkout_with_chai_rule.scan('MK1')
      expect(checkout_with_chai_rule.total).to eq ('$20.34')
    end

    it 'should take into account multiple rules' do
      3.times do
        checkout_with_rules.scan('AP1')
      end
      checkout_with_rules.scan('CH1')
      expect(checkout_with_rules.total).to eq('$16.61')
    end
  end

end