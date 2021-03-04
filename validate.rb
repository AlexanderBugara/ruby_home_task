# frozen_string_literal: true

NINE = 9
TWO = 2
TEN = 10
CC_LENGTH = 16
CC_LENGTH_WITH_SEPARATORS = 19
CC_INPUT_ERROR_MESSAGE = 'Your cc input has an error'

def validate(ccn)
  validate_input(ccn)
  ccn = normalise(ccn)
  check_digit = get_check_sum(ccn)
  (check_digit % TEN).zero?
rescue ArgumentError
  puts CC_INPUT_ERROR_MESSAGE
  false
end

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
  ccn.gsub(/[\- \s]/, '')
end

p '------------success cases-----------------'
p '4561 2612 1234 5467'
p validate('4561 2612 1234 5467')
p '>>'
p '5425-2334-3010-9903'
p validate('5425-2334-3010-9903')

p '------------fail cases-----------------'
p '45-61 2612 1234 546-7'
p validate('45-61 2612 1234 546-7')
p '>>'
p '4561 2612 1234 5469'
p validate('4561 2612 1234 5469')
p '>>'
p '\' \''
p validate('')
