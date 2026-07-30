# app/controllers/concerns/price_calculations

module PriceCalculations

  # 小計（個々）
  def calculate_item_total(price, count)
    price * count
  end

  # 合計金額（全体用）
  def calculate_total_sum(items)
    items.sum
  end

  # セッションのカートの合計金額を計算
  def cart_calculation
    session[:cart].each do |item|
      product = Product.find(item["id"].to_i)
      item["price"] = product.price
      item["item_price"] = calculate_item_total(item["price"], item["count"])
    end
    puts session[:cart].inspect
    puts session.inspect

    session[:cart_total] = calculate_total_sum(session[:cart].map { |item| item["item_price"] })
  end

  # ユーザのカート合計金額を再計算
  def user_cart_calculation
    cart = Cart.find_by(user_id: current_user.id)
    @item_totals = cart.cart_items.map { |item| calculate_item_total(item.product.price, item.quantity) }
    @cart_total = calculate_total_sum(@item_totals)
    #p cart.cart_items.inspect
    #p @item_totals.inspect
    #p @cart_total.inspect
  end
  
end