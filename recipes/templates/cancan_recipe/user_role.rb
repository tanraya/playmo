# encoding: utf-8

class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  validates :user_id, :presence => true, :numericality => true
  validates :role_id, :presence => true, :numericality => true

  def to_s
    "user_id: #{user_id}, role_id: #{role_id}"
  end
end
