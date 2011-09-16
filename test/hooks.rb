require 'active_support'

# http://thomasmango.com/2011/09/02/getting-to-know-active-support-callbacks/
module Playmo
  module Generators
    INSTALLERS = [
      :JavascriptFramework,
      :Html5Support,
    ]

    module Callbacks
      def self.extended(base)
        base.class_eval do
          include ActiveSupport::Callbacks
          define_callbacks :bundle_install
        end
      end

      def after_bundle_install(method, &block)
        define_callbacks :bundle_install
        set_callback(:bundle_install, :after, method, &block)
      end

      def before_bundle_install(method, &block)
        set_callback(:bundle_install, :before, method, &block)
      end
    end

    class InstallGenerator
      extend Callbacks
      after_bundle_install :run_delayed_generators!

      def install
        INSTALLERS.each do |installer|
          puts installer
        end

        install_gems!
      end

      def install_gems!
        run_callbacks(:bundle_install) do
          puts 'bundle install'
        end
      end

      def run_delayed_generators!
        puts 'Here we run all delayed generators'
      end
    end
  end
end

x = Playmo::Generators::InstallGenerator.new
x.install