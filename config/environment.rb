# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Lunch::Application.initialize!

class SystemStatus
  @@status = false

  def self.start
    @@status = true
  end

  def self.stop
    @@status = false
  end

  def self.start?
    @@status
  end
end
