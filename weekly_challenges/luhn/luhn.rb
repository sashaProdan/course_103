class Luhn
  def self.create(number)
    luhn = Luhn.new(number * 10)
    digit = (luhn.checksum) % 10 == 0 ? 0 : 10 - (luhn.checksum % 10)
    (number * 10) + digit
  end

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def edited_number
    number.to_s.split('').map!(&:to_i)
  end

  def addends
    edited_number.reverse!
      .map!.with_index { |val, i| i.even? ? val : val * 2 }
      .map! { |digit| digit > 9 ? digit - 9 : digit }.reverse!
  end

  def checksum
    addends.map!.inject(:+)
  end

  def valid?
    checksum % 10 == 0
  end
end
