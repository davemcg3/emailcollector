# frozen_string_literal: true

# An instance of this class represents a user that can login to the site
class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
