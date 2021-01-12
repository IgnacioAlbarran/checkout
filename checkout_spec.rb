require 'spec_helper'
require './checkout.rb'
require 'byebug'
require 'json'

describe 'checkout' do
  before do
    @new_prices = JSON.parse(File.read('./new_prices.json'))
  end
  it 'is initialized with a price policy code' do
    checkout = Checkout.new('two_for_one')

    expect(checkout.class).to be(Checkout)
  end

  it 'knows the price policy code to applied' do
    checkout = Checkout.new('two_for_one')

    expect(checkout.rule).to eq('two_for_one')
  end

  it 'scans products adding them' do
    checkout = Checkout.new('two_for_one')

    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')

    expect(checkout.products).to eq(['VOUCHER', 'TSHIRT'])
  end

  it 'calculates the total amount bought' do
    checkout = Checkout.new('normal')

    checkout.scan('TSHIRT')

    expect(checkout.total).to eq(20)
  end

  it 'calculates the total amount for multiple items' do
    checkout = Checkout.new('normal')

    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')

    expect(checkout.total).to eq(20)
  end

  it 'calculates prices applying two-for-one discount' do
    checkout = Checkout.new('two_for_one')

    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')

    expect(checkout.total).to eq(10)
  end

  it 'calculates prices applying two-for-one discount' do
    checkout = Checkout.new('five_percent')

    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')

    expect(checkout.total).to eq(76)
  end

  it 'calculates the total amount for multiple items with their disccounts' do
    checkout = Checkout.new('two_for_one')
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('MUG')
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    expect(checkout.total).to eq(77.5)
  end

  it 'calculates prices using new prices sent by JSON' do
    checkout = Checkout.new('normal', @new_prices)

    expect(checkout.prices['TSHIRT']).to eq(30)
  end
end