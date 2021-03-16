NINE = 9
TWO = 2
TEN = 10
CC_INPUT_ERROR_MESSAGE = 'Your cc input has an error'


# Card with number
class Card
  attr_accessor :ccn

  def initialize(ccn)
    @ccn = ccn
  end

  def validate
    validate_input(ccn)
    ccn = normalise(ccn)
    check_digit = get_check_sum(ccn)
    (check_digit % TEN).zero?
  rescue ArgumentError
    puts CC_INPUT_ERROR_MESSAGE
    false
  end

  private

  def get_check_sum(ccn)
    ccn.chars.each_with_index.reduce(0) do |memo, (element, index)|
      temp_digit = element.to_i
      unless (index + 1).even?
        temp_digit *= TWO
        temp_digit -= NINE unless temp_digit < NINE
      end
      memo + temp_digit
    end
  end

  def validate_input(ccn)
    raise ArgumentError unless ccn.match?("[0-9]{4}[\-:\s]?[0-9]{4}[\-:\s]?[0-9]{4}[\-:\s]?[0-9]{4}")
  end

  def normalise(ccn)
    ccn.to_s.gsub(/[\- \s]/, '')
  end
end
