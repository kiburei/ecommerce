class ShoppingCart < ApplicationRecord
  has_many :order_items, dependent: :destroy

  def self.update_cart(cart, current_shop)
    sub_total_price = cart.order_items.sum(:total_cost)
    # Factor VAT, Discounts or Coupons
    vat = sub_total_price * Shop.last.vat_rate.to_i / 100
    total_price = cart.order_items.sum(:total_cost) + vat
    cart.update(sub_total_price: sub_total_price, total_price: total_price)
  end

end
