require 'active_support'

class Account
  include ActiveSupport::Callbacks

  def fire(event, &block)
    run_callbacks event do
      block.call
    end
  end

  def after(event, &block)
    class_eval do
      define_callbacks event unless respond_to? "_#{event}_callbacks"

      set_callback event, :after do
        block.call
      end
    end
  end

  def before(event, &block)
    class_eval do
      define_callbacks event unless respond_to? "_#{event}_callbacks"

      set_callback event, :before do
        block.call
      end
    end
  end

  def save
    before :save do
      puts "before_save block is called"
    end

    after :save do
      puts "after_save block is called"
    end
      
    fire :save do
      puts 'save'
    end
  end
end

Account.new.save
