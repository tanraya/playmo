class BaseClass
  def self.alert
    yield if block_given?
  end
end

class SuperClass < BaseClass
  alert do
    puts "What's up, Doc?"
  end
end

