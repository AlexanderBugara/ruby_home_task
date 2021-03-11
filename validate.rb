# frozen_string_literal: true

require 'logger'
require 'tmpdir'

NINE = 9
TWO = 2
TEN = 10
CC_LENGTH = 16
CC_LENGTH_WITH_SEPARATORS = 19
CC_INPUT_ERROR_MESSAGE = 'Your cc input has an error'
MINIMUM_AGE = 13
AGE_VIOLATION_MESSAGE = 'Your age is under 13 years old. You can\'t do this operation'

# generic interface for User and UserWrapper
module UserAbstract
  def initialize(name, age, card) end
  attr_reader :name, :age, :card
end

# To make logs
class UserWrapper
  include UserAbstract
  attr_reader :user, :logger

  def initialize(name, age, card)
    @user = User.new(name, age, card)
    tmp_logger = Logger.new File.open('/tmp/ruby_user.log', 'a')
    tmp_logger.level = Logger::INFO
    @logger = tmp_logger
  end

  def validate_credit_card
    logger.info(">> validate ccn #{user.card.ccn}")
    logger.info(">> validation is #{user.validate_credit_card}")
  end

  def name
    logger.info(">> accessing user name #{user.name}")
    user.name
  end

  def age
    logger.info(">> accessing user age #{user.age}")
    user.age
  end

  def card
    logger.info(">> accessing card #{user.card.ccn}")
    user.card
  end
end

# User with name, age and card
class User
  include UserAbstract

  attr_accessor :name, :age, :card

  def initialize(name, age, card)
    @name = name
    @age = age
    @card = card
  end

  def validate_credit_card
    if age < MINIMUM_AGE
      puts AGE_VIOLATION_MESSAGE
      false
    else
      card.validate
    end
  end
end

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

p '------------success cases-----------------'

card = Card.new('4561 2612 1234 5467')

user = User.new('Alex', 13, card)

p user.validate_credit_card

card = Card.new('5425-2334-3010-9903')

user = User.new('Alex', 15, card)

p user.validate_credit_card

p '------------fail by age cases-----------------'

card = Card.new('4561 2612 1234 5467')

user = User.new('Alex', 12, card)

p user.validate_credit_card

card = Card.new('5425-2334-3010-9903')

user = User.new('Alex', 10, card)

p user.validate_credit_card

p '------------fail by card cases-----------------'

card = Card.new('45-61 2612 1234 546-7')

user = User.new('Alex', 15, card)

p user.validate_credit_card

card = Card.new('4561 26 12 123 4 5469')

user = User.new('Alex', 101, card)

p user.validate_credit_card

p '------------with logger-----------------'

card = Card.new('4561 2612 1234 5467')
wrapper = UserWrapper.new('Alex', 13, card)
wrapper.name
wrapper.age
wrapper.validate_credit_card

card = Card.new('5425-2334-3010-9903')
wrapper = UserWrapper.new('Goseph', 12, card)
wrapper.name
wrapper.age
wrapper.validate_credit_card
