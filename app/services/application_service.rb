class ApplicationService < Dry::Operation
  extend Dry::Initializer

  def self.call(...)
    new(...).call
  end
end
