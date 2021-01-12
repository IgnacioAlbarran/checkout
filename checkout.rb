require 'byebug'
class Checkout
  PRICES = {
    'TSHIRT': 20,
    'VOUCHER': 5,
    'MUG': 7.5
  }

  def initialize(price_rule, new_prices = nil)
    @rule = price_rule
    @prices = new_prices || PRICES
    @products = []
    @cart = Hash.new
  end

  def rule
    @rule
  end

  def prices
    @prices
  end

  def products
    @products
  end

  def cart
    @cart
  end

  def scan(product)
    @products << product
  end

  def total
    prepare_cart
    total = 0

    cart.each_key do |product|
      total += apply_rules(product)
    end

    total
  end

  private

  def prepare_cart
    @cart = Hash.new
    @products_ordered = @products.uniq.to_a

    @products_ordered.each do |prod|
      cart[prod] = @products.count(prod)
    end
  end

  def apply_rules(product)
    return apply_two_for_one(product) if (product == 'VOUCHER' && rule == 'two_for_one' && cart['VOUCHER'] > 1)
    return apply_five_percent(product) if (rule == 'five_percent' && product == 'TSHIRT' && cart['TSHIRT'] >= 3)
    PRICES[product.to_sym] * cart[product]
  end

  def apply_two_for_one(product)
    number_to_bill = cart[product].even? ? cart[product] / 2 : cart[product] /2  + 1
    number_to_bill * PRICES[product.to_sym]
  end

  def apply_five_percent(product)
    cart[product] * PRICES[product.to_sym] * 0.95
  end
end