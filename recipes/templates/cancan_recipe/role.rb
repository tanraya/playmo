# encoding: utf-8

class Role < ActiveRecord::Base
  has_many :users, :through => :user_role

  attr_accessible :name, :description
  validates :name, :description, :presence => true

  def to_s
  	name
  end
end
