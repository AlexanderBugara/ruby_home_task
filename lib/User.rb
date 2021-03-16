
MINIMUM_AGE = 13
AGE_VIOLATION_MESSAGE = 'Your age is under 13 years old. You can\'t do this operation'

# User with name, age and card
class User
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