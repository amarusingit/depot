r


















an_order = Order.create(name: "Dave Thomas", email: "dave@example.com", address: "123 Main St", pay_type: "check") 

orders = Order.create([ { name: "Dave Thomas",email: "dave@example.com", address: "123 Main St", pay_type: "check"}, { name: "Andy Hunt", email: "andy@example.com", address: "456 Gentle Drive", pay_type: "po" } ] )


orders = Order.where(name: 'Dave').order("pay_type, shipped_at DESC")



orders = LineItem.find_by_sql("select line_items.* from line_items, orders " + " where order_id = orders.id " +" and orders.name = 'Dave Thomas' ")












items = LineItem.find_by_sql (" select *, " +" products.price as unit_price, " +" quantity*products.price as total_price, " +" products.title as title " +" from line_items, products " +" where line_items.product_id = products.id ") 
li = items[0]
puts "#{li.title}: #{li.quantity}x#{li.unit_price} => #{li.total_price}"
















