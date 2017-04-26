customer = Input.cart.customer
discount = 1 # Discount start variable 

# You can use this array to make sure these items are not discounted
array = [8294234817, 8294234753, 8294234433, 8313434113, 8294233281, 8294233345, 8294269633, 8294268993]

# This function checks for specialty items that you might not want your Customers applied coupons to
def sale()
    itemCount = 0
    if Input.cart.discount_code == nil # IF the cart has a discount code
      puts "" # Shopify would not allow the proper logic here so this is a work around IF statement
    else # IF NOT remove it
      Input.cart.line_items.each do |line_item|
        product = line_item.variant.product
        if (product.id == 9556534093)
          Input.cart.discount_code.reject(message: "Not usable with lab pre-orders")
        end
      end
    end
end


# The logic below works like this >
#       IF there are using a customer account (non guest checkout) > check if they are tagged for discounts > then check further discounts
#       IF NOT (theyre using a guest checkout) > still check to see if they are trying to use a promo code on a special item
if customer
    customer.tags.each do |tag|
      if tag.include?("ProDeal")
        discount = 0.60
      elsif tag.include?("Pro50")
        discount = 0.50
      elsif tag.include?("Employees")
        discount = 0.28
      end
  end
    
 # The commented out can be used if desired. This IF statement checks to see if there is already a discount applied.
 # LOGIC: If there is a discount code > do NOT give them a discount beyond that

 # if Input.cart.discount_code == nil
    # Cycle through all products in the cart to check
    Input.cart.line_items.each do |line_item|
      product = line_item.variant.product
      if !array.include?(product.id)   # If the product is not a bike, apply discount to each item
        line_item.change_line_price(line_item.line_price * discount, message: "Employee pricing ")
      end
    end
 # end
    sale() # checking for further discount on special / sale items
else
  sale() # checking for further discount on special / sale items
end # End

# Output to the Cart the new changes
Output.cart = Input.cart
