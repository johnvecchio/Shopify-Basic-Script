customer = Input.cart.customer
discount = 1

# Non or diff discount array
array = [8294234817, 8294234753, 8294234433, 8313434113, 8294233281, 8294233345, 8294269633, 8294268993]

# put any sale ID in here for
def sale()
    itemCount = 0
    if Input.cart.discount_code == nil
      puts ""
    else
      Input.cart.line_items.each do |line_item|
        product = line_item.variant.product
        if (product.id == 9556534093)
          Input.cart.discount_code.reject(message: "Not usable with lab pre-orders")
        end
      end
    end
end



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
 # if there is a discount code, dont give them a discount beyond that
 # if Input.cart.discount_code == nil
    # Cycle through all products in the cart to check
    Input.cart.line_items.each do |line_item|
      product = line_item.variant.product
      if !array.include?(product.id)   # If the product is not a bike, apply discount to each item
        line_item.change_line_price(line_item.line_price * discount, message: "Employee pricing ")
      end
    end
 # end
        sale()
else
  sale()
end # End

# Output to the Cart the new changes
Output.cart = Input.cart
