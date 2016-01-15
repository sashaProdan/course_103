
def reduce(array, default = 0)
  counter = 0
  accum = default

  while counter < array.size
    accum = yield(accum, array[counter])
    counter += 1
  end

  accum
end

array = [1, 2, 3, 4, 5]
reduce(array) { |acc, num| acc + num }
reduce(array, 10) { |acc, num|  acc + num }
reduce(array) { |acc, num| acc + num if num.odd? }
