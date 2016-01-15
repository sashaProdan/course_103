
def select(array)
  counter = 0
  final_arr = []

  while counter < array.size
    current_element = array[counter]
    final_arr << current_element if yield(current_element)
    counter += 1
  end

  final_arr
end

arr = [1, 2, 3, 4, 5]

select(arr) { |num| num.odd? }
