require 'pry'

def consolidate_cart(cart)

cart_hash = {}

  cart.each do |item_hash|
    item_hash.each do |item, data_hash|
      if cart_hash[item].nil?
        cart_hash[item] = data_hash.merge({:count => 1})
      else
        cart_hash[item][:count] += 1
      end
    end
  end

return cart_hash

end


def apply_coupons(cart, coupons)

cart_hash = cart
temp_hash = {}

  coupons.each do |coupon_hash|
    # add coupon to cart
    item = coupon_hash[:item]

    if !cart_hash[item].nil? && cart_hash[item][:count] >= coupon_hash[:num]
      temp_hash = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => cart[item][:clearance],
        :count => 1
      }
    }

      if cart_hash["#{item} W/COUPON"].nil?
        cart_hash.merge!(temp_hash)
      else
        cart_hash["#{item} W/COUPON"][:count] += 1
      end

      cart_hash[item][:count] -= coupon_hash[:num]

    end
  end

return cart_hash

end


# cart =
# {
#   "PEANUTBUTTER" => {:price => 3.00, :clearance => true,  :count => 2},
#   "KALE"         => {:price => 3.00, :clearance => false, :count => 3},
#   "SOY MILK"     => {:price => 4.50, :clearance => true,  :count => 1}
# }

def apply_clearance(cart)

cart_hash = cart

  cart_hash.each do |item, item_hash|
    if cart_hash[item][:clearance]
      new_price = cart_hash[item][:price]*0.8
      cart_hash[item][:price] = new_price.round(2)
    end
  end

  return cart_hash

end



def checkout(cart, coupons)

  consolidated_cart = consolidate_cart(cart)

  if consolidated_cart.length > 0
    apply_coupons(consolidated_cart, coupons)
    apply_clearance(consolidated_cart)
  end

  




end
