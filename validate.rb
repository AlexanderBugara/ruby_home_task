# frozen_string_literal: true

NINE = 9

TWO = 2

TEN = 10

CVV_LENGTH = 16

CVV_LENGTH_WITH_SEPARATORS = 19

SEPARATOR_POSITION = 5

COUNTER_INCREMENT = 1

EXCLUDE_INDEX1 = 4

EXCLUDE_INDEX2 = 9

EXCLUDE_INDEX3 = 14

CVV_INPUT_ERROR_MESSAGE = 'Your cvv input has an error'

def validate(cvv)
  validate_input(cvv)
  normilised_cvv = normilise_if_need_it(cvv)
  check_digit = get_check_sum(normilised_cvv)
  (check_digit % TEN).zero?
rescue ArgumentError
  puts CVV_INPUT_ERROR_MESSAGE
end

def get_check_sum(cvv)
  cvv.chars.each_with_index.reduce(0) do |memo, (element, index)|
    temp_digit = element.to_i
    unless (index + 1).even?
      temp_digit *= TWO
      temp_digit -= NINE unless temp_digit < NINE
    end
    memo + temp_digit
  end
end

def validate_input(cvv)
  raise ArgumentError if cvv.empty?
  raise ArgumentError if cvv.size != CVV_LENGTH && cvv.size != CVV_LENGTH_WITH_SEPARATORS
end

def normilise_if_need_it(cvv)
  if cvv.size == CVV_LENGTH_WITH_SEPARATORS
    collection = cvv.chars.clone
    indexes_to_reject = [EXCLUDE_INDEX1, EXCLUDE_INDEX2, EXCLUDE_INDEX3]
    result = collection.reject.each_with_index { |_, ix| indexes_to_reject.include? ix }
    return result.join if result.join.match?(/\A-?\d+\Z/)

    raise ArgumentError
  end
  cvv
end

p validate('5425-2334-3010-9903')