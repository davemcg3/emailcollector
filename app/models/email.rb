# frozen_string_literal: true

# An instance of this class represents a collected email address
class Email < ActiveRecord::Base
  validates :email, presence: true
  validates_uniqueness_of :email, scope: [:source]
end
