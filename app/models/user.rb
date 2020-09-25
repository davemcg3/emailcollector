# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
