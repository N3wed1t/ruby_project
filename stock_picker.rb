def stock_picker(stock)
  profit = {
    init_profit: 0,
    start_index: 0,
    compare_index: 0
  }
  stock.each_with_index do |value, index|
    stock[index..].each_with_index do |check_value, check_index|
      check_profit = check_value - value
      next unless check_profit > profit[:init_profit]

      profit[:init_profit] = check_profit
      profit[:start_index] = index
      profit[:compare_index] = check_index + index
    end
  end
  [profit[:start_index], profit[:compare_index]]
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
