# encoding: utf-8
require 'playmo/version'
require 'active_support'

module Playmo
  extend ActiveSupport::Autoload

  autoload :Cli
  autoload :Recipe

  class ::Object
    include Playmo::Recipe
  end
end



