# To make logs
require 'logger'
require 'tmpdir'

class UserWrapper
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