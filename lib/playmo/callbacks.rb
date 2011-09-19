module Playmo
  module Callbacks
    include ActiveSupport::Callbacks

    #def after_bundle_install(method, &block)
      define_callbacks :bundle_install
      set_callback(:bundle_install, :after, method, &block)
    #end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

    end

    def after(name, &block)
      run_callbacks name do
        yield &block
        puts "after #{name}"
      end
    end

    def before(name, &block)

    end

  end
end