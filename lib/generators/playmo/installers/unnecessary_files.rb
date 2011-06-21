module Playmo::Generators::Installers
  class UnnecessaryFiles
    def initialize
      notify "Deleteing unnecessary files like public/404.html and others"
      delete_unnecessary_files
    end

  protected

    def delete_unnecessary_files

    end
  end
end