require "logger"

module Mypeople
  autoload :Bot,              'mypeople/bot'
  autoload :Client,           'mypeople/client'
  autoload :File,             'mypeople/file'
  autoload :Group,            'mypeople/group'
  autoload :Member,           'mypeople/member'
  autoload :Requirement,      'mypeople/requirement'

  # Raise this when we hit a Trello error.
  Error = Class.new(StandardError)

  # This specific error is thrown when your key is invalid. You should get a new one.
  InvalidKey = Class.new(Error)

  # This error is thrown when your client has not been configured
  ConfigurationError = Class.new(Error)

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.client
    @client ||= Client.new
  end

  def self.configure(&block)
    reset!
    client.configure(&block) 
  end

  def self.reset!
    @client = nil
  end
end
