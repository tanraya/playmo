# encoding: utf-8
require 'playmo/version'
require 'active_support'

module Playmo
  extend ActiveSupport::Autoload

  autoload :Cli
  autoload :Recipe
  autoload :Cookbook
  autoload :Cook

  class ::Object
    include Playmo::Recipe
    include Playmo::Cookbook
    include Playmo::Cook
  end
end



