module Playmo
  module Generators
    class Base < Rails::Generators::Base
      def app_name
        RAILS_ROOT.split('/').last.capitalize
      end

      def framework
        @framework
      end

      def remove(path)
        remove_file path, :verbose => false
      end

      def copy(from ,to)
        copy_file from ,to, :verbose => false
      end

      def _template(from ,to)
        template from ,to, :verbose => false
      end
    end
  end
end