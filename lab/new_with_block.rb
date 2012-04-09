class Yay
  def initialize(name, &block)
    puts "Hello #{name}, from initialize"
    self.instance_eval &block
  end
end

Yay.new "Lamer" do
  puts "That's right"
end