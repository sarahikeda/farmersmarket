require 'rspec'
require 'pry'
require_relative '../lib/market'

describe Checkout do
  # let(:checkout) { Checkout.new }
  # it 'should receive a list of product rules' do

  # end

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

  context 'totaling products sold' do
    let(:checkout) { Checkout.new }

    it 'should keep track of the running total' do
      checkout.scan('MK1')
      checkout.scan('AP1')
      expect(checkout.total).to eq ('$10.75')
    end

    # it 'should keep track of the running total' do
    #   checkout.scan('CH1')
    #   checkout.scan('AP1')
    #   checkout.scan('CF1')
    #   checkout.scan('MK1')
    #   expect(checkout.total).to eq ('$20.34')
    # end
  end

end