require "dry/operation/extensions/active_record"

class ApplicationService < Dry::Operation
  extend Dry::Initializer
  include Dry::Operation::Extensions::ActiveRecord

  def self.call(...)
    new(...).call
  end
end
