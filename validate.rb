# frozen_string_literal: true

require './lib/user_wrapper'
require './lib/user'
require './lib/card'

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
